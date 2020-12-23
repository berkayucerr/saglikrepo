import 'package:asistan_saglik/dosyalar/spor.dart';
import 'package:asistan_saglik/screens/Spor/spor_detay_screen.dart';
import 'package:asistan_saglik/screens/Spor/sporilksayfa.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final Color carbonBlack = Color(0xff1a1a1a);

class Spor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Spor();
  }
}

class _Spor extends State {
  List<SporBilgileri> aktivite_listesi;
  Box sporBox;
  @override
  void initState() {
    super.initState();
    aktivite_listesi = new List<SporBilgileri>();
    sporBox = Hive.box<SporBilgileri>('sporBilgileri');
    if (sporBox.isNotEmpty) {
      for (var i = 0; i < sporBox.length; i++) {
        aktivite_listesi.add(sporBox.getAt(i));
      }
    }
  }

  @override
  Widget build(BuildContext contexta) {
    return aktivite_listesi.isEmpty
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Spor',
                style: TextStyle(color: Colors.orangeAccent),
              ),
              centerTitle: true,
            ),
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
              tooltip: 'Spor Aktivitesi Ekle',
              child: Icon(Icons.add),
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SporIlk(contexta)),
                );
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Spor',
                style: TextStyle(color: Colors.orangeAccent),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.orange,
                    ),
                    tooltip: 'Listeyi Boşalt',
                    onPressed: () {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: carbonBlack,
                              title: Text(
                                'Liste Boşaltılsın mı?',
                                style: TextStyle(color: Colors.orange),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      'Listeyi Boşaltmak istediğinize emin misiniz?',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Evet',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      sporBox.clear();
                                      aktivite_listesi.clear();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Hayır',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                    })
              ],
            ),
            body: Container(
              color: carbonBlack,
              child: ListView.builder(
                itemCount: aktivite_listesi.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 4,
                    child: ListTile(
                      leading: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              sporBox.deleteAt(index);
                              sporBox.compact();
                              aktivite_listesi.removeAt(index);
                            });
                          }),
                      title: Text(aktivite_listesi[index].sportipi.toString() +
                          ' ' +
                          aktivite_listesi[index].baslangiczamani +
                          ' ' +
                          '- ' +
                          aktivite_listesi[index].bitiszamani),
                      subtitle: Text(aktivite_listesi[index].kalori.toString() +
                          ' Kalori'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SporDetay(aktivite_listesi[index].l)),
                        );
                      },
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
                  MaterialPageRoute(builder: (context) => SporIlk(contexta)),
                );
              },
            ));
  }
}
