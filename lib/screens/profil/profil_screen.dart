import 'package:asistan_saglik/dosyalar/kullanicibilgileri.dart';
import 'package:asistan_saglik/screens/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main/nav.dart';

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {
  kullanicibilgileri k = kullanicibilgileri();
  String _mail, _pass;

  var user = FirebaseAuth.instance.currentUser;
  Widget BilgileriDuzenle() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kullanıcı Bilgilerini Düzenle',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Isminiz",
                      hintText: "Isim",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.length < 3)
                      return "İsim alanı en az 3 karakter olmalıdır";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      value.trim();
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      hintText: "mail@",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (!value.contains('@') || !value.contains('.com'))
                      return "Geçerli bir eposta adresi giriniz";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _mail = value.trim();
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Boyunuz",
                      hintText: "Boy",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isEmpty) return "Boş Geçmeyiniz";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      //
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Yaş",
                      hintText: "Yaş",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isEmpty) return "Boş Geçmeyiniz";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      //
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Kilonuz",
                      hintText: "Kilo",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isEmpty) return "Boş Geçmeyiniz";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      //
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Sifre",
                      hintText: "sifre",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      )),
                  onChanged: (value) {
                    setState(() {
                      _pass = value.trim();
                    });
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (_mail != null) user.updateEmail(_mail);
                      if (_pass != null) user.updatePassword(_pass);
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    k.mail = FirebaseAuth.instance.currentUser.email;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BilgileriDuzenle()));
              },
              tooltip: 'Profil Bilgilerini Düzenle',
              icon: Icon(Icons.edit),
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () async {
                await signOut();
              },
              icon: Icon(Icons.logout),
              color: Colors.orange,
            ),
          ],
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
                        k.mail,
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

  Future signOut() async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KayitGiris(),
          ));
    } catch (e) {
      print(e);
    }
  }
}
