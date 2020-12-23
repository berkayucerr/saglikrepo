import 'dart:async';

import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:asistan_saglik/screens/main/nav.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

class YeniSpor extends StatefulWidget {
  BuildContext _context2;
  int _x;
  String sportipi;

  YeniSpor(int a, sportipi, BuildContext context) {
    this._x = a;
    this.sportipi = sportipi;
    this._context2 = context;
  }

  @override
  _YeniSporState createState() => _YeniSporState(_x, sportipi, _context2);
}

class _YeniSporState extends State<YeniSpor> {
  BuildContext _context2;
  Box userBox, sporBox;
  int value;
  String sportipi;
  _YeniSporState(int val, String sportipi, BuildContext context) {
    this.value = val;
    this.sportipi = sportipi;
    this._context2 = context;
  }

  Timer _timer, _timer_2;
  SporBilgileri s = new SporBilgileri();
  double _lati = 0.0, _longti = 0.0, _kaloriSayac = 0.0;
  String _baslangicZamani = 'Henüz Başlamadı';
  int i = 0, _counter = 0, _kaloriSayac2 = 0, _kilo;
  String tmp;
  bool _timerControl = false;

  _getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _lati = geoposition.latitude;
    _longti = geoposition.longitude;
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerControl) {
      _timer.cancel();
    }
  }

  Location tmpp;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    userBox = Hive.box<String>('kullaniciBilgileri');
    tmp = userBox.get('kilo', defaultValue: '0');
    _kilo = int.parse(tmp);
    sporBox = Hive.box<SporBilgileri>('sporBilgileri');
    s.l = new List<Location>();
  }

  _locationEkle() {
    _timer = Timer.periodic(new Duration(seconds: 8), (timer) {
      tmpp = new Location();
      tmpp.lati = _lati;
      tmpp.longti = _longti;
      s.l.add(tmpp);
      _getCurrentLocation();
      print(_lati.toString() + ' - ' + _longti.toString());
      print('location OK');
    });
    _timer_2 = Timer.periodic(new Duration(seconds: 60), (timer) {
      print(_timer_2.tick);
      _counter++;
      _kaloriSayac = double.parse(((_counter / 60) * _kilo * value).toString());
      String _temp = _kaloriSayac.toString();
      _kaloriSayac2 = int.parse(_temp.split(".")[0]);
      print('Kalori OK');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Spor Aktivitesi',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                'Başlangıç Zamanı : $_baslangicZamani',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Icon(
                Icons.run_circle,
                color: Colors.orangeAccent,
                size: 100,
              ),
              SizedBox(
                height: 200,
              ),
              Column(
                children: <Widget>[
                  Visibility(
                    child: FlatButton(
                      child: Text('Aktiviteyi Başlat'),
                      onPressed: () {
                        if (!_timerControl) {
                          _timerControl = true;
                          _locationEkle();
                          setState(() {
                            _baslangicZamani = (Jiffy().hour.toString() +
                                '.' +
                                Jiffy().minute.toString());
                          });
                        }
                      },
                      color: Colors.orange,
                    ),
                    visible: !_timerControl,
                  ),
                  Visibility(
                    child: FlatButton(
                      child: Text('Aktiviteyi Bitir'),
                      onPressed: () {
                        if (_timerControl) {
                          _timerControl = false;
                          if (s.l.isNotEmpty) {
                            s.bitiszamani = (Jiffy().hour.toString() +
                                '.' +
                                Jiffy().minute.toString());
                            s.baslangiczamani = _baslangicZamani;
                            _timer_2.cancel();
                            _timer.cancel();
                            s.kalori = _kaloriSayac2;
                            s.sportipi = sportipi;
                            sporBox.add(s);
                          }
                        }
                        Navigator.pop(context);
                        Navigator.pop(_context2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      color: Colors.orange,
                    ),
                    visible: _timerControl,
                  )
                ],
              )
            ],
          )),
        ));
  }
}
