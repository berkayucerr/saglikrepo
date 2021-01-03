import 'package:asistan_saglik/dosyalar/kullanicibilgileri.dart';
import 'package:asistan_saglik/screens/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../main/nav.dart';

final Color carbonBlack = Color(0xff1a1a1a);

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {
  kullanicibilgileri k = kullanicibilgileri();
  String _mail, _pass, _boy, _yas, _kilo, _isim;
  final _formKey = GlobalKey<FormState>();
  Box userBox;
  String vals;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<String>('kullaniciBilgileri');
    this._isim = userBox.get('isim', defaultValue: 'boş');
    this._boy = userBox.get('boy', defaultValue: 'boş');
    this._yas = userBox.get('yas', defaultValue: 'boş');
    this._kilo = userBox.get('kilo', defaultValue: 'boş');
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
        color: carbonBlack,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange,
                      ),
                      labelText: "Isminiz",
                      hintText: "Isim",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      )),
                  validator: (value) {
                    if (value.isNotEmpty) if (value.length < 3)
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
                  style: TextStyle(color: Colors.orange),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.orange,
                      ),
                      labelText: "Email",
                      hintText: "mail@",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isNotEmpty) if (!value.contains('@') ||
                        !value.contains('.com'))
                      return "Geçerli bir e-posta adresi giriniz";
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
                  style: TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange,
                      ),
                      labelText: "Boyunuz",
                      hintText: "Boy",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isNotEmpty) if (!value.contains('.'))
                      return "Boş Geçmeyiniz";
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
                  style: TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange,
                      ),
                      labelText: "Yaş",
                      hintText: "Yaş",
                      
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isNotEmpty) if (value.length > 2)
                      return "Lütfen Geçerli Bir Yaş Giriniz!";
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
                  style: TextStyle(color: Colors.orange),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange,
                      ),
                      labelText: "Kilonuz",
                      hintText: "Kilo",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isNotEmpty) {
                      if (value.length > 4) {
                        return "Lütfen Geçerli Bir Kilo Giriniz";
                      } else if (value.contains('.') || value.contains(',')) {
                        return "Lütfen Kilonuzu Tam Sayı Giriniz (81 gibi).";
                      }
                    }
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
                  style: TextStyle(color: Colors.orange),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.orange,
                      ),
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
                  child: Text(
                    'Kaydet',
                    style: TextStyle(color: Colors.orange),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        if (_mail != null) user.updateEmail(_mail);
                        if (_pass != null) user.updatePassword(_pass);
                        if (_isim != null) userBox.put('isim', _isim);
                        if (_boy != null) userBox.put('boy', _boy);
                        if (_yas != null) userBox.put('yas', _yas);
                        if (_kilo != null) userBox.put('kilo', _kilo);
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
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
            style: TextStyle(color: Colors.orange),
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
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.person,
                      size: 80,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'İsminiz : $_isim',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    Text(
                      'Boyunuz: $_boy',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    Text(
                      'Yaşınız : $_yas',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    Text(
                      'Kilonuz : $_kilo',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
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
