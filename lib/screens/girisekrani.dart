import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../nav.dart';

class KayitGiris extends StatefulWidget {
  @override
  KayitGirisState createState() => KayitGirisState();
}

class KayitGirisState extends State<KayitGiris> {
  bool _loggedIn = false;
  String _isim, _email, _sifre, _boy, _yas, _kilo;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return KarsilamaEkrani();
  }

  Widget KarsilamaEkrani() {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sağlık Asistanı',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Scaffold(
          body: Container(
              color: Colors.black,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      color: Colors.grey,
                      child: Text("Kayıt Ol"),
                      onPressed: () => _kayitaYonlendir(context),
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Colors.orangeAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      color: Colors.grey,
                      child: Text("Giriş Yap"),
                      onPressed: () => _giriseYonlendir(context),
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Colors.orangeAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )
                ],
              ))),
        ));
  }

  Widget _GirisEkrani() => Scaffold(
      appBar: AppBar(
        title: Text(
          "Giriş Yap",
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            child: ListView(
              children: <Widget>[
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
                      _email = value.trim();
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
                      _sifre = value.trim();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Giriş Yap"),
                        onPressed: () => _loginController(context),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.orangeAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ));
  Widget _KayitEkrani() => Scaffold(
      appBar: AppBar(
        title: Text(
          "Kayit Ol",
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
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
                      _email = value.trim();
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
                      _sifre = value.trim();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Kayıt Ol"),
                        onPressed: () => _saveFormData(context),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.orangeAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ));

  void _saveFormData(BuildContext context2) {
    auth
        .createUserWithEmailAndPassword(email: _email, password: _sifre)
        .then((_) {
      _loggedIn = true;
      _yonlendir(context2);
    });
  }

  void _yonlendir(BuildContext context2) {
    Navigator.pop(context2);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ));
  }

  void _giriseYonlendir(BuildContext context2) {
    if (_loggedIn)
      Navigator.pop(context2);
    else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _GirisEkrani(),
          ));
    }
  }

  void _kayitaYonlendir(BuildContext context2) {
    if (_loggedIn)
      Navigator.pop(context2);
    else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _KayitEkrani(),
          ));
    }
  }

  void _loginController(BuildContext context2) {
    auth.signInWithEmailAndPassword(email: _email, password: _sifre).then((_) {
      _yonlendir(context2);
    });
  }
}
