import 'dart:async';

import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

class YeniSpor extends StatefulWidget {
  int _x;
  String sportipi;

  YeniSpor(int a, sportipi) {
    this._x = a;
    this.sportipi = sportipi;
  }

  @override
  _YeniSporState createState() => _YeniSporState(_x, sportipi);
}

class _YeniSporState extends State<YeniSpor> {
  Box userBox;
  int value;
  String sportipi;
  _YeniSporState(int val, String sportipi) {
    this.value = val;
    this.sportipi = sportipi;
  }

  Timer _timer, _timer_2;
  spor s = new spor();
  double _lati = 0.0, _longti = 0.0, _kaloriSayac = 0.0;
  String _baslangicZamani = 'Henüz Başlamadı';
  int i = 0, _counter = 0, _kalori = 0, _kaloriSayac2 = 0,_kilo;
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

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    userBox=Hive.box<String>('kullaniciBilgileri');
    tmp=userBox.get('kilo',defaultValue: '0');
    _kilo=int.parse(tmp);
  }

  _locationEkle() {
    _timer = Timer.periodic(new Duration(seconds: 10), (timer) {
      s.l.add(new location(_lati, _longti));
      _getCurrentLocation();
      print(_lati.toString() + ' - ' + _longti.toString());
    });
    _timer_2 = Timer.periodic(new Duration(seconds: 60), (timer) {
      print(_timer_2.tick);
      _counter++;
      _kaloriSayac = double.parse(((_counter / 60) * _kilo * value)
          .toString()); //burası düzenlenecek ikinci parametre kilo
      String aq = _kaloriSayac.toString();
      print(aq);
      _kaloriSayac2 = int.parse(aq.split(".")[0]);
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
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  FlatButton(
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
                  SizedBox(
                    width: 50,
                  ),
                  FlatButton(
                    child: Text('Aktiviteyi Bitir'),
                    onPressed: () {
                      if (_timerControl) {
                        _timerControl = false;
                        s.bitiszamani = (Jiffy().hour.toString() +
                            '.' +
                            Jiffy().minute.toString());
                        s.baslangiczamani = _baslangicZamani;
                        _timer_2.cancel();
                        _timer.cancel();
                        s.kalori = _kaloriSayac2;
                        s.sportipi = sportipi;
                      }
                      Navigator.pop(context);
                    },
                    color: Colors.orange,
                  ),
                ],
              )
            ],
          )),
        ));
  }
}
