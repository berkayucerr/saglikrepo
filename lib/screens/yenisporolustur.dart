import 'dart:async';

import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:flutter/material.dart';

class Yenispor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new YeniSporEkrani();
}

class YeniSporEkrani extends State<Yenispor> {
  String _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Yeni Aktivite Ekle',
          style: TextStyle(color: Colors.orangeAccent),
        ),
      ),
      body: Container(
        child: DropdownButton(
          iconDisabledColor: Colors.orange,
          iconEnabledColor: Colors.orange,
          focusColor: Colors.orange,
          value: _selectedValue,
          dropdownColor: Colors.orangeAccent,
          items: <String>["Koşu", "Yürüyüş", "Bisiklet"]
              .map((label) => DropdownMenuItem(
                    child: Text(label),
                    value: label,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Spor Aktivitesi Ekle',
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sporx(_selectedValue)),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget Sporx(String v) {
    spor s = new spor(v);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.sportipi,
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
          children: <Widget>[
            Container(
              child: Column(),
              padding: EdgeInsets.only(top: 10.0),
              width: 200,
              height: 200,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.save),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
