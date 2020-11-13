import 'package:asistan_saglik/dosyalar/yiyecekler.dart';
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Diyet Ekranı',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          centerTitle: true,
        ),
        body: _Ekran(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Diyet Ekle',
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiyetEkle()),
            );
          },
        ));
  }
}

class DiyetEkle extends StatelessWidget {
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
      body: Container(
        color: Colors.black,
      ),
    );
  }
}

Widget _Ekran() {
  List<yiyecekler> yiyecek = List();
  yiyecek.add(new yiyecekler(0, 'Elma', 50));
  yiyecek.add(new yiyecekler(1, 'Armut', 70));
  yiyecek.add(new yiyecekler(2, 'Kebap', 700));
  yiyecek.add(new yiyecekler(3, 'Döner', 680));
  yiyecek.add(new yiyecekler(4, 'Sebze', 100));

  return Scaffold(
    body: Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: yiyecek.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orangeAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 4,
            child: ListTile(
              title: Text(yiyecek[index].isim),
            ),
          );
        },
      ),
    ),
  );
}
