import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../main/nav.dart';

final Color carbonBlack = Color(0xff1a1a1a);

class KayitGiris extends StatefulWidget {
  @override
  _KayitGirisState createState() => _KayitGirisState();
}

class _KayitGirisState extends State<KayitGiris> {
  Box userBox;
  bool _loggedIn = false;
  String _isim, _email, _sifre, _boy, _yas, _kilo;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<String>('kullaniciBilgileri');
  }

  @override
  Widget build(BuildContext context) {
    return KarsilamaEkrani();
  }

  Widget KarsilamaEkrani() {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sağlık Asistanı',
            style: TextStyle(color: Colors.orange),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Scaffold(
          body: Container(
              color: carbonBlack,
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
        color: carbonBlack,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
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
                    if (value.isNotEmpty) {
                      if (!value.contains('@') || !value.contains('.com'))
                        return "Geçerli bir eposta adresi giriniz";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
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
                      _sifre = value.trim();
                    });
                  },
                  validator: (value) {
                    if (value.isNotEmpty) {
                      if (value.length < 6)
                        return "Şifre En Az 6 Karakter Uzunluğunda Olmalıdır!";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
                    return null;
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Giriş Yap"),
                        onPressed: () {
                          _loginController(context);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.orangeAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Şifremi Unuttum"),
                        onPressed: () => _resetPassword(context),
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
                          borderSide: BorderSide(color: Colors.orangeAccent))),
                  validator: (value) {
                    if (value.isNotEmpty) {
                      if (value.length < 3)
                        return "İsim alanı en az 3 karakter olmalıdır";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
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
                    if (value.isNotEmpty) {
                      if (!value.contains('@') || !value.contains('.com'))
                        return "Geçerli bir eposta adresi giriniz";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
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
                    if (value.isNotEmpty) {
                      if (!value.contains('.'))
                        return "Geçerli Bir Boy Giriniz (1.72 gibi)";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
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
                    if (value.isNotEmpty) {
                      if (value.length > 2)
                        return "Lütfen Geçerli Bir Yaş Giriniz";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
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
                      } else if (value.contains('.') || value.contains(',')){
                        return "Lütfen Kilonuzu Tam Sayı Giriniz (81 gibi).";}
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
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
                      _sifre = value.trim();
                    });
                  },
                  validator: (value) {
                    if (value.isNotEmpty) {
                      if (value.length < 6)
                        return "Şifre En Az 6 Karakter Uzunluğunda Olmalıdır!";
                    } else
                      return "Lütfen Bu Alanı Boş Geçmeyiniz";
                    return null;
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
    if (_formKey.currentState.validate()) {
      setState(() {
        auth
            .createUserWithEmailAndPassword(email: _email, password: _sifre)
            .then((_) {
          userBox.put('isim', _isim);
          userBox.put('boy', _boy);
          userBox.put('kilo', _kilo);
          userBox.put('yas', _yas);
          _loggedIn = true;

          _yonlendir(context2);
        });
      });
    }
  }

  void _yonlendir(BuildContext context2) {
    popf(context2);
    popf(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ));
  }

  void _giriseYonlendir(BuildContext context2) {
    if (_loggedIn)
      popf(context2);
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
      popf(context2);
    else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _KayitEkrani(),
          ));
    }
  }

  void _loginController(BuildContext context2) {
    if (_formKey.currentState.validate()) {
      setState(() {
        auth
            .signInWithEmailAndPassword(email: _email, password: _sifre)
            .then((_) {
          _yonlendir(context2);
        });
      });
    }
  }

  void popf(BuildContext context) {
    Navigator.pop(context);
  }

  void _resetPassword(BuildContext context) {
    if (_formKey.currentState.validate()) {
      setState(() {
        auth.sendPasswordResetEmail(email: _email);
        popf(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TextButton(
                    child: Text(
                      'Şifre Sıfırlama Bağlantınız Gönderildi Lütfen Buraya Tıklayınız',
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => _GirisEkrani()));
                    })));
      });
    }
  }
}
