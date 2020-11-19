import 'package:asistan_saglik/dosyalar/kullanicibilgileri.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State {
  kullanicibilgileri k = kullanicibilgileri();
  @override
  Widget build(BuildContext context) {
    k.kayit("Berkay ÜÇER", "berkayucer@gmail.com", "1.83", "22", "80");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [],
          title: Text(
            'Profil Ekranı',
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
                child: Container(
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text(
                        k.isim,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Yaş: " + k.yas + " Boy: " + k.boy + " Kilo: " + k.kilo,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
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
        ));
  }
}