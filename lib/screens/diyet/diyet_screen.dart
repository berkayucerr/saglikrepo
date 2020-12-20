import 'package:asistan_saglik/dosyalar/besinler.dart';
import 'package:asistan_saglik/screens/main/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

final Color carbonBlack = Color(0xff1a1a1a);

class Diyet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DiyetState();
  }
}

class _DiyetState extends State<Diyet> {
  var user = FirebaseAuth.instance.currentUser;
  List<Besinler> liste = new List<Besinler>();
  Box besinBox;
  int _toplamKalori = 0;
  @override
  void initState() {
    super.initState();
    besinBox = Hive.box<Besinler>('besinBilgileri');
    if (besinBox.isNotEmpty) {
      for (var i = 0; i < besinBox.length; i++) {
        liste.add(besinBox.getAt(i));
        _toplamKalori += liste[i].miktar * liste[i].kalori;
      }
    }
  }

  @override
  Widget build(BuildContext contexta) {
    if (liste.isEmpty)
      return Scaffold(
        appBar: AppBar(title: Text('Diyet',style: TextStyle(color:Colors.orange)),centerTitle: true,backgroundColor: Colors.black,),
          body: Container(
            color: carbonBlack,
            child: Center(
              child: Text(
                'Liste Boş',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Diyet Ekle',
            child: Icon(Icons.add),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewDiyet(contexta)),
              );
            },
          ));
    else
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Diyet  (Toplam Kalori: ${_toplamKalori})',
              style: TextStyle(color: Colors.orangeAccent),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.orange,
                  ),
                  tooltip: 'Listeyi Boşalt',
                  onPressed: () {
                    setState(() {
                      besinBox.clear();
                      liste.clear();
                    });
                  })
            ],
          ),
          body: Container(
            color: carbonBlack,
            child: ListView.builder(
              itemCount: liste.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 4,
                  child: ListTile(
                    title: Text(liste[index].isim +
                        ' ${liste[index].miktar}' +
                        ' adet'),
                    subtitle: Text(liste[index].kalori.toString() +
                        ' Kalori' +
                        '      Toplam Kalori=${liste[index].miktar * liste[index].kalori}'),
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
                MaterialPageRoute(builder: (context) => NewDiyet(contexta)),
              );
            },
          ));
  }
}

class NewDiyet extends StatefulWidget {
  BuildContext _context2;
  NewDiyet(BuildContext context){
this._context2=context;
  }
  @override
  State<StatefulWidget> createState() {
    return DiyetEkle(_context2);
  }
}

class DiyetEkle extends State<NewDiyet> {
  BuildContext _context2;
  DiyetEkle(BuildContext context)
  {
    this._context2=context;
  }
  List<Besinler> y = new List<Besinler>();
  Box besinBox;
  @override
  void initState() {
    super.initState();
    besinBox = Hive.box<Besinler>('besinBilgileri');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yeni Diyet Ekle',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Diyetlistesi').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                color: Colors.black,
                child: Center(
                    child: Text(
                  'Data loading please wait...',
                  style: GoogleFonts.droidSans(
                    fontSize: 80,
                    color: Colors.orange,
                    fontWeight: FontWeight.w900,
                  ),
                )));
          int _snapshotLength = snapshot.data.documents.length;
          for (int i = 0; i < _snapshotLength; i++) {
            String a = snapshot.data.documents[i]['isim'];
            int b = snapshot.data.documents[i]['kalori'];
            Besinler _yiyecek = new Besinler();
            _yiyecek.id = i;
            _yiyecek.isim = a;
            _yiyecek.kalori = b;
            _yiyecek.value = false;
            _yiyecek.miktar = 0;
            y.add(_yiyecek);
          }

          return Scaffold(
              body: Container(
                color: carbonBlack,
                child: ListView.builder(
                    itemCount: _snapshotLength,
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        color: carbonBlack,
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              new CheckboxListTile(
                                  value: y[index].value,
                                  title: new Text(
                                    y[index].isim +
                                        ': ' +
                                        y[index].kalori.toString() +
                                        ' kalori',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: carbonBlack,
                                  checkColor: Colors.orange,
                                  onChanged: (bool val) {
                                    setState(() {
                                      y[index].value = val;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      y[index].miktar++;
                                    });
                                  }),
                              Text('${y[index].miktar}',
                                  style: TextStyle(color: Colors.orange)),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (y[index].miktar > 0)
                                        y[index].miktar--;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: 'Diyet Ekle',
                child: Icon(Icons.add),
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < y.length; i++) {
                      if (y[i].value && y[i].miktar != 0) {
                        besinBox.add(y[i]);
                      }
                    }
                    Navigator.pop(context);
                    Navigator.pop(_context2);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                  });
                },
              ));
        },
      ),
    );
  }
}
