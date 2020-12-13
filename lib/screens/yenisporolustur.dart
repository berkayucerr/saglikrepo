import 'dart:async';

import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:asistan_saglik/screens/spor_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

class YeniSpor extends StatefulWidget {
  @override
  _YeniSporState createState() => _YeniSporState();
}

class _YeniSporState extends State<YeniSpor> {
  Box<List<location>> activities = Hive.box('activities');
  double _lati, _longti;
  _getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _lati = geoposition.latitude;
      _longti = geoposition.longitude;
    });
  }

  List<location> l = new List<location>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    l.add(new location(0, 0));
  }

  int i = 0;
  bool _timerControl = false;
  Timer _timer;
  _ekle() async {
    _timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      debugPrint(timer.tick.toString());
      _getCurrentLocation();
      if (l[i].lati != _lati ||
          l[i].longti != _longti ||
          ((l[i].lati != _lati) && (l[i].longti != _longti))) {
        i++;
        l.add(new location(_lati, _longti));
      }
      print(l[i].lati);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              child: Icon(Icons.add),
              onPressed: () async {
                if (_timerControl == false) {
                  await _ekle();
                  _timerControl = true;
                }
              }),
          FlatButton(
            child: Icon(Icons.alarm),
            onPressed: () {
              if (_timerControl == true) {
                _timerControl = false;
                _timer.cancel();
                activities.add(l);
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
              for (var i = 0; i < l.length; i++) {
                print(l[i].lati.toString() + ' ve ' + l[i].longti.toString());
              }
            });
          },
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
