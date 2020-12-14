import 'dart:async';

import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

class YeniSpor extends StatefulWidget {
  @override
  _YeniSporState createState() => _YeniSporState();
}

class _YeniSporState extends State<YeniSpor> {
  spor s = new spor();
  double _lati, _longti;
  int i = 0;
  bool _timerControl = false;
  Timer _timer;
  _getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _lati = geoposition.latitude;
      _longti = geoposition.longitude;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    firtsLocation();
    print(new DateTime.now());
  }

  void firtsLocation() async {
    await Future.delayed(const Duration(seconds: 9), () {
      print('FirstInsertionCheckpoint $_lati $_longti');
      s.l.add(new location(_lati, _longti));
    });
  }

  _ekle() async {
    _timer = Timer.periodic(new Duration(seconds: 10), (timer) {
      debugPrint(timer.tick.toString());
      _getCurrentLocation();
      if ((s.l[i].lati != _lati ||
              s.l[i].longti != _longti ||
              ((s.l[i].lati != _lati) && (s.l[i].longti != _longti))) &&
          _lati != null) {
        i++;
        s.l.add(new location(_lati, _longti));
      }
      print(s.l[i].lati);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerControl) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              child: Icon(Icons.add),
              onPressed: () async {
                if (!_timerControl) {
                  await _ekle();
                  _timerControl = true;
                }
              }),
          FlatButton(
            child: Icon(Icons.alarm),
            onPressed: () {
              if (_timerControl) {
                _timerControl = false;
                _timer.cancel();
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            setState(() {
              for (var i = 0; i < s.l.length; i++) {
                print(
                    s.l[i].lati.toString() + ' ve ' + s.l[i].longti.toString());
              }
            });
          },
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
