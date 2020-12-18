import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Rapor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RaporState();
  }
}

class _RaporState extends State {
  Box stepsBox;

  int todaySteps;

  @override
  void initState() {
    super.initState();
    stepsBox = Hive.box<int>('steps');
    todaySteps = stepsBox.get(999999, defaultValue: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Rapor Ekranı',
              style: TextStyle(color: Colors.orangeAccent)),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black,
          child: ListView(children: [
            ListTile(
              title: Text(
                "***Dünya Sağlık Örgütünün Açıkladığı Günlük Atılması Gereken Adım Sayısı 10.000'dir.",
                style: TextStyle(color: Colors.pink),
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              title: Text(
                'Attığınız Adım Sayısı ',
                style: TextStyle(color: Colors.orange),
              ),
              subtitle: Text(
                '$todaySteps',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              title: Text(
                'Spor ile yaktığınız kalori sayısı ',
                style: TextStyle(color: Colors.orange),
              ),
              subtitle: Text(
                '$todaySteps',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              title: Text(
                'Diyetinizin Toplam Kalori Sayısı ',
                style: TextStyle(color: Colors.orange),
              ),
              subtitle: Text(
                '$todaySteps',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ]),
        ));
  }
}
