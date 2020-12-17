import 'dart:async';

import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jiffy/jiffy.dart';

class YeniSpor extends StatefulWidget {
  @override
  _YeniSporState createState() => _YeniSporState();
}

class _YeniSporState extends State<YeniSpor> {
  spor s = new spor();
  double _lati, _longti;
  int i = 0, _sayac = 0, _kaloriSayac2 = 0;
  double _kaloriSayac = 0.0;
  bool _timerControl = false;
  Timer _timer, _timer_2;
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

  _ekle(int _speed) async {
    _timer = Timer.periodic(new Duration(seconds: 10), (timer) {
      debugPrint(timer.tick.toString());
      _getCurrentLocation();
      if (s.l[0].lati == null) {
        s.l[0].lati = _lati;
        s.l[0].longti = _longti;
      } else {
        if ((s.l[i].lati != _lati ||
                s.l[i].longti != _longti ||
                ((s.l[i].lati != _lati) && (s.l[i].longti != _longti))) &&
            _lati != null) {
          i++;
          s.l.add(new location(_lati, _longti));
        }
      }
      print(s.l[i].lati);
    });
    _timer_2 = Timer.periodic(new Duration(seconds: 60), (timer) {
      print(timer);
      _sayac++;
      _kaloriSayac = double.parse(((_sayac / 60) * 80 * _speed)
          .toString()); //burası düzenlenecek ikinci parametre kilo
      String aq = _kaloriSayac.toString();
      _kaloriSayac2 = int.parse(aq.split(".")[0]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerControl) {
      _timer.cancel();
    }
  }

  String _zamanHesap() {
    return (Jiffy().hour.toString() + '.' + Jiffy().minute.toString());
  }

  Widget IlkSayfa(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Aktiviteyi Seç',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              ListTile(
                title: Text(
                  'Yürüyüş Aktivitesi (4 KM hız)',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                tileColor: Colors.orangeAccent,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IkinciSayfa(4, context)));
                },
              ),
              SizedBox(
                height: 100,
              ),
              ListTile(
                tileColor: Colors.orangeAccent,
                title: Text('Koşu Aktivitesi (8 KM hız)',
                    style: TextStyle(color: Colors.black, fontSize: 30)),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IkinciSayfa(8, context)));
                },
              ),
              SizedBox(
                height: 100,
              ),
              ListTile(
                tileColor: Colors.orangeAccent,
                title: Text('Bisiklet Aktivitesi (15 KM hız)',
                    style: TextStyle(color: Colors.black, fontSize: 30)),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IkinciSayfa(15, context)));
                },
              ),
            ],
          )),
    );
  }

  Widget IkinciSayfa(int _value, BuildContext context) {
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
                'Başlangıç Zamanı : ${s.baslangiczamani} \nYakılan Kalori : ${_kaloriSayac2}',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 35),
              ),
              SizedBox(
                height: 100,
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
                    onPressed: () async {
                      if (!_timerControl) {
                        await _ekle(_value);
                        _timerControl = true;
                        s.baslangiczamani = _zamanHesap();
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
                        _timer.cancel();
                        _timer_2.cancel();
                        s.bitiszamani = _zamanHesap();
                        s.kalori = _kaloriSayac2;
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

  @override
  Widget build(BuildContext context) {
    return IlkSayfa(context);
  }
}
