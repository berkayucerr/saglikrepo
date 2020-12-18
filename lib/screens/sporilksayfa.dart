import 'package:flutter/material.dart';

import 'Spor/create_new_activity.dart';
 class SporIlk extends StatefulWidget {
   @override
   _SporIlkState createState() => _SporIlkState();
 }
 
 class _SporIlkState extends State<SporIlk> {
   @override
   Widget build(BuildContext context) {
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
                          builder: (context) => YeniSpor(4,'Yürüyüş Aktivitesi')));
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
                          builder: (context) => YeniSpor(8,'Koşu Aktivitesi')));
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
                          builder: (context) => YeniSpor(15,'Bisiklet Aktivitesi')));
                },
              ),
            ],
          )),
    );
   }}
 
 
