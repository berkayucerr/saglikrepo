import 'yenisporolustur.dart';
import 'package:flutter/material.dart';

class Spor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SporState();
  }
}

class _SporState extends State {
  @override
  Widget build(BuildContext context) {
    return AktiviteListesi(context);
  }
}

Widget AktiviteListesi(BuildContext context) {
  List aktivite_listesi = new List();

  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Spor Ekranı',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
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
                title: Text(aktivite_listesi[index].sporTipi),
                subtitle: Text(
                    aktivite_listesi[index].sporsuresi.toString() + " Dakika"),
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
            MaterialPageRoute(builder: (context) => Yenispor()),
          );
        },
      ));
}

class AktiviteEkle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yeni Spor Aktivitesi Ekle',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(color: Colors.black),
    );
  }
}

Widget _Ekran() {}
