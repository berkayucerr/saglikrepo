import 'package:flutter/material.dart';

class Genel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GenelState();
  }
}

class _GenelState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Genel Ekranı',
          style: TextStyle(color: Colors.orangeAccent),
        ),
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
              child: Text('Atılan Adım'),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.orange]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(27.0),
                      bottomRight: Radius.circular(27.0),
                      topLeft: Radius.circular(27.0),
                      topRight: Radius.circular(27.0))),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 200,
              height: 200,
              child: Text('Yakılan Kalori'),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.orange]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(27.0),
                      bottomRight: Radius.circular(27.0),
                      topLeft: Radius.circular(27.0),
                      topRight: Radius.circular(27.0))),
            ),
          ],
        ),
      ),
    );
  }
}
