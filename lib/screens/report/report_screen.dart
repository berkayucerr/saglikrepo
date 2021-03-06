import 'dart:async';

import 'package:asistan_saglik/dosyalar/besinler.dart';
import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

final Color carbonBlack = Color(0xff1a1a1a);

class Rapor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RaporState();
  }
}

class _RaporState extends State {
  Box _stepsBox, _diyetBox, _sporBox, _hedef;
  int _todaySteps,
      _diyetKalori = 0,
      _sporKalori = 0,
      hedefAdim = 0,
      todayDayNoRef,
      haftalikAdim,
      aylikAdim;
  Besinler bTmp;
  SporBilgileri sTmp;
  bool _adimKontrol = false;
  @override
  void initState() {
    super.initState();
    _sporBox = Hive.box<SporBilgileri>('sporBilgileri');
    _stepsBox = Hive.box<int>('steps');
    _hedef = Hive.box<int>('hedef');
    hedefAdim = _hedef.get('hedefAdim', defaultValue: 10000);
    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    _todaySteps = _stepsBox.get(todayDayNo, defaultValue: 0);
    _diyetBox = Hive.box<Besinler>('besinBilgileri');
    if (_diyetBox.isNotEmpty)
      for (var i = 0; i < _diyetBox.length; i++) {
        bTmp = new Besinler();
        bTmp = _diyetBox.getAt(i);
        _diyetKalori += bTmp.kalori * bTmp.miktar;
      }
    if (_sporBox.isNotEmpty)
      for (var i = 0; i < _sporBox.length; i++) {
        sTmp = new SporBilgileri();
        sTmp = _sporBox.getAt(i);
        _sporKalori += sTmp.kalori;
      }
    _stepControl();
    todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    todayDayNoRef = todayDayNo;
    haftalikAdim = _todaySteps;
    if (todayDayNo > 7) {
      while (todayDayNoRef != todayDayNo - 7) {
        haftalikAdim += _stepsBox.get(todayDayNoRef - 1, defaultValue: 0);
        todayDayNoRef--;
      }
    } else {
      while (todayDayNoRef != 0) {
        haftalikAdim += _stepsBox.get(todayDayNoRef - 1, defaultValue: 0);
        todayDayNoRef--;
      }
    }

    todayDayNoRef = todayDayNo;
    aylikAdim = _todaySteps;

    if (todayDayNo > 31) {
      while (todayDayNoRef != todayDayNo - 30) {
        aylikAdim += _stepsBox.get(todayDayNoRef - 1, defaultValue: 0);
        todayDayNoRef--;
      }
    } else {
      while (todayDayNoRef != 0) {
        aylikAdim += _stepsBox.get(todayDayNoRef - 1, defaultValue: 0);
        todayDayNoRef--;
      }
    }
  }

  _stepControl() async {
    this._adimKontrol = _kontrol();
  }

  bool _kontrol() {
    if (_todaySteps < hedefAdim) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Rapor', style: TextStyle(color: Colors.orange)),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black,
          child: ListView(children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text(
                "***Dünya Sağlık Örgütünün Açıkladığı Günlük Atılması Gereken Adım Sayısı 10.000'dir.",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Visibility(
              visible: _adimKontrol,
              child: Card(
                color: carbonBlack,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    'Hâlâ Atmanız Gereken ${hedefAdim - (_todaySteps)} Adım Var.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            Card(
              color: carbonBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Atılan Adım Sayısı: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle: Text(
                  _todaySteps?.toString() ?? '0',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Card(
              color: carbonBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Spor ile yaktığınız kalori sayısı: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle:
                    Text('$_sporKalori', style: TextStyle(color: Colors.blue)),
              ),
            ),
            Card(
              color: carbonBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Diyetinizin Toplam Kalori Sayısı: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle:
                    Text('$_diyetKalori', style: TextStyle(color: Colors.blue)),
              ),
            ),
            Card(
              color: carbonBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Haftalık Attığınız Adım Sayısı: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle:
                    Text('$haftalikAdim', style: TextStyle(color: Colors.blue)),
              ),
            ),
            Card(
              color: carbonBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Son Bir Aydır Attığınız Adım Sayısı: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle:
                    Text('$aylikAdim', style: TextStyle(color: Colors.blue)),
              ),
            )
          ]),
        ));
  }
}
