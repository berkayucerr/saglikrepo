import 'package:flutter/material.dart';

import 'create_new_activity.dart';
 class SporIlk extends StatefulWidget {
   BuildContext _context2;
   SporIlk(BuildContext context){
     this._context2=context;
   }
   @override
   _SporIlkState createState() => _SporIlkState(_context2);
 }
 
 class _SporIlkState extends State<SporIlk> {
   BuildContext _context2;
   _SporIlkState(BuildContext context){
     this._context2=context;
   }
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
                          builder: (context) => YeniSpor(4,'Yürüyüş Aktivitesi',_context2)));
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
                          builder: (context) => YeniSpor(8,'Koşu Aktivitesi',_context2)));
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
                          builder: (context) => YeniSpor(15,'Bisiklet Aktivitesi',_context2)));
                },
              ),
            ],
          )),
    );
   }}
 
 
