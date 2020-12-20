import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

final Color carbonBlack = Color(0xff1a1a1a);

class Genel extends StatefulWidget {
  @override
  _GenelState createState() => _GenelState();
}

class _GenelState extends State<Genel> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  Box<int> stepsBox = Hive.box('steps');
  int todaySteps, hedef;
  Box hedefBox;
  double _percent = 0;
  @override
  void initState() {
    super.initState();
    startListening();
    hedefBox = Hive.box<int>('hedef');
    hedef = hedefBox.get('hedefAdim', defaultValue: 10000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Genel',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
        actions: <Widget>[
          Slider(  
                            value: hedef.toDouble(),  
                            min: 10000.0,  
                            max: 20000.0,  
                            divisions: 10,  
                            activeColor: Colors.orange,  
                            inactiveColor: carbonBlack,  
                            label: 'Adım Sayısı',  
                            onChanged: (double newValue) {  
                              setState(() {  
                                hedef = newValue.round();  
                                hedefBox.put('hedefAdim', hedef);
                                });  
                              },  
                              semanticFormatterCallback: (double newValue) {  
                                return '${newValue.round()} dollars';  
                              }  
                            )  
        ],
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
                    todaySteps?.toString() ?? '0',
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: 80,
                      color: Colors.orange,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "Adım Atıldı",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            new CircularPercentIndicator(
              radius: 300.0,
              lineWidth: 10.0,
              percent: _percent,
              header: new Text(todaySteps.toString()),
              center: new Icon(
                Icons.run_circle,
                size: 100.0,
                color: carbonBlack,
              ),
              backgroundColor: carbonBlack,
              progressColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

/*Plugin Kısmı*/
  @override
  void dispose() {
    stopListening();
    super.dispose();
  }

  void startListening() {
    _pedometer = Pedometer();
    _subscription = _pedometer.pedometerStream.listen(
      getTodaySteps,
      onError: _onError,
      onDone: _onDone,
      cancelOnError: true,
    );
  }

  void _onDone() => print("Finished pedometer tracking");
  void _onError(error) => print("Flutter Pedometer Error: $error");

  Future<int> getTodaySteps(int value) async {
    print(value);
    int savedStepsCountKey = 999999;
    int savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);

    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    if (value < savedStepsCount) {
      // Upon device reboot, pedometer resets. When this happens, the saved counter must be reset as well.
      savedStepsCount = 0;
      // persist this value using a package of your choice here
      stepsBox.put(savedStepsCountKey, savedStepsCount);
    }

    // load the last day saved using a package of your choice here
    int lastDaySavedKey = 888888;
    int lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);

    // When the day changes, reset the daily steps count
    // and Update the last day saved as the day changes.
    if (lastDaySaved < todayDayNo) {
      lastDaySaved = todayDayNo;
      savedStepsCount = value;

      stepsBox
        ..put(lastDaySavedKey, lastDaySaved)
        ..put(savedStepsCountKey, savedStepsCount);
    }

    setState(() {
      todaySteps = value - savedStepsCount;
    });
    stepsBox.put(todayDayNo, todaySteps);
    _percent = todaySteps / hedef;
    return todaySteps; // this is your daily steps value.
  }

  void stopListening() {
    _subscription.cancel();
  }
}
