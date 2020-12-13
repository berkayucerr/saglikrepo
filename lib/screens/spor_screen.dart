import 'package:asistan_saglik/dosyalar/location.dart';
import 'package:hive/hive.dart';

import 'yenisporolustur.dart';
import 'package:flutter/material.dart';

class Spor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Spor();
  }
}

class _Spor extends State {
  Box<List<location>> activities = Hive.box('activities');
  List<List<location>> aktivite_listesi = new List<List<location>>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*for (var i = 0; i < activities.length; i++) {
      aktivite_listesi.add(activities.getAt(i));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Spor Ekranı',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          centerTitle: true,
          actions: [
            FlatButton(
                onPressed: () {
                  setState(() {});
                },
                child: Icon(Icons.ac_unit))
          ],
        ),
        body: Container(
          color: Colors.black,
          child: ListView.builder(
            itemCount: aktivite_listesi.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 4,
                child: ListTile(
                  title: Text(aktivite_listesi[index].toString()),
                  subtitle: Text(aktivite_listesi[index].length.toString()),
                ),
              );
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
              MaterialPageRoute(builder: (context) => YeniSpor()),
            );
          },
        ));
  }
}
