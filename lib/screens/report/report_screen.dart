import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

class Rapor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RaporState();
  }
}

class _RaporState extends State {
  Box<int> stepsBox = Hive.box('steps');

  int todaySteps;

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
            child: ListView(
                padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        Text(
                          'Hedef 10bin Adım',
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Atılan Adım Sayısı ',
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Günlük Yakılan Kalori Sayısı ',
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Diyetinizin Toplam Kalori Sayısı',
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Yakılan Toplam Kalori Sayısı ',
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                            color: Colors.orange,
                            onPressed: () {
                              setState(() {});
                            },
                            child: Icon(Icons.ac_unit))
                      ],
                    ),
                  )
                ])));
  }
}
