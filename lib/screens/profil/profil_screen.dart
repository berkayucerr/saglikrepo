import 'package:asistan_saglik/dosyalar/kullanicibilgileri.dart';
import 'package:asistan_saglik/screens/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../main/nav.dart';

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {
  kullanicibilgileri k = kullanicibilgileri();
  String _mail, _pass, _boy, _yas, _kilo, _isim;
  Box userBox;
  String vals;
  
  @override
  void initState() {
    super.initState();
    userBox=Hive.box<String>('kullaniciBilgileri');
    this._isim=userBox.get('isim',defaultValue: 'boş');
    this._boy=userBox.get('boy',defaultValue: 'boş');
    this._yas=userBox.get('yas',defaultValue: 'boş');
    this._kilo=userBox.get('kilo',defaultValue: 'boş');
  }

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
        color: Colors.grey,
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
                          borderSide: BorderSide(color: Colors.orangeAccent),
                          )),
                  validator: (value) {
                    if (value.length < 3)
                      return "İsim alanı en az 3 karakter olmalıdır";
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isim = value.trim();
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
                      _boy = value.trim();
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
                      _yas = value.trim();
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
                      _kilo = value.trim();
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
                FlatButton(
                  child: Text('Kaydet',style: TextStyle(color: Colors.orange),),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      if (_mail != null) user.updateEmail(_mail);
                      if (_pass != null) user.updatePassword(_pass);
                      userBox.put('isim', _isim);
                      userBox.put('boy', _boy);
                      userBox.put('yas', _yas);
                      userBox.put('kilo', _kilo);
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
                height: 400,
                child: Center(
                  child: Column(children: <Widget>[
                    SizedBox(height: 20,),
                    Icon(Icons.person,size: 80,),
                    SizedBox(height: 30,),
                    Text('İsminiz : $_isim',style: TextStyle(color:Colors.black,fontSize: 25),),
                    Text('Boyunuz: $_boy',style: TextStyle(color:Colors.black,fontSize: 25),),
                    Text('Yaşınız : $_yas',style: TextStyle(color:Colors.black,fontSize: 25),),
                    Text('Kilonuz : $_kilo',style: TextStyle(color:Colors.black,fontSize: 25),),
                  ]),
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
