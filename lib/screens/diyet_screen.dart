import 'package:asistan_saglik/dosyalar/yiyecekler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Diyet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DiyetState();
  }
}

class _DiyetState extends State {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    List<yiyecekler> liste = new List<yiyecekler>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Diyet Ekranı',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black,
          child: ListView.builder(
            itemCount: liste.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 4,
                child: ListTile(
                  title: Text(liste[index].isim),
                  subtitle: Text(liste[index].kalori.toString() + " Dakika"),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Diyet Ekle',
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewDiyet()),
            );
          },
        ));
  }
}

class NewDiyet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DiyetEkle();
  }
}

class DiyetEkle extends State<NewDiyet> {
  List<yiyecekler> y = new List<yiyecekler>();
  List<yiyecekler> y2 = new List<yiyecekler>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yeni Diyet Ekle',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Diyetlistesi').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Data loading please wait...');
          int _snapshotLength = snapshot.data.documents.length;
          for (int i = 0; i < _snapshotLength; i++) {
            String a = snapshot.data.documents[i]['isim'];
            int b = snapshot.data.documents[i]['kalori'];
            y.add(new yiyecekler(a, b));
          }

          return Scaffold(
              body: ListView.builder(
                  itemCount: _snapshotLength,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      child: new Container(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(
                          children: <Widget>[
                            new CheckboxListTile(
                                value: y[index].value,
                                title: new Text(y[index].isim +
                                    ': ' +
                                    y[index].kalori.toString() +
                                    ' kalori'),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool val) {
                                  setState(() {
                                    y[index].value = val;
                                  });
                                })
                          ],
                        ),
                      ),
                    );
                  }),
              floatingActionButton: FloatingActionButton(
                tooltip: 'Diyet Ekle',
                child: Icon(Icons.add),
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: () {
                  setState(() {
                    y2.clear();
                    for (int i = 0; i < y.length; i++) {
                      if (y[i].value) {
                        y2.add(y[i]);
                      }
                    }
                    Navigator.pop(context);
                  });
                },
              ));
        },
      ),
    );
  }
}
