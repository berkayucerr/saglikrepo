import 'package:flutter/material.dart';
import '../nav.dart';

class KayitGiris extends StatefulWidget {
  @override
  KayitGirisState createState() => KayitGirisState();
}

class KayitGirisState extends State<KayitGiris> {
  String isim, email, sifre;
  String textIsim = "", textEmail = "", textSifre = "";
  final formKey = GlobalKey<FormState>();

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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              color: Colors.grey,
              child: Text("Kayıt Ol"),
              onPressed: () => _kayitaYonlendir(),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orangeAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              color: Colors.grey,
              child: Text("Giriş Yap"),
              onPressed: () => _giriseYonlendir(),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orangeAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          )
        ],
      )),
    );
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
            key: formKey,
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
                  onSaved: (data) => email = data,
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
                  onSaved: (data) => sifre = data,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Giriş Yap"),
                        onPressed: () => _loginController(),
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
            key: formKey,
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
                  onSaved: (data) => isim = data,
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
                  onSaved: (data) => email = data,
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
                  onSaved: (data) => sifre = data,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Kayıt Ol"),
                        onPressed: () => _saveFormData(),
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

  void _saveFormData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        textIsim = isim;
        textEmail = email;
        _yonlendir();
      });
    }
  }

  void _yonlendir() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ));
  }

  void _giriseYonlendir() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _GirisEkrani(),
        ));
  }

  void _kayitaYonlendir() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _KayitEkrani(),
        ));
  }

  void _loginController() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      setState(() {
        textEmail = email;
        textSifre = sifre;
        if (textSifre == "123" && textEmail == "asd@gmail.com") {
          _yonlendir();
        } else {
          return 'Email ve Şifre Yanlış!';
        }
      });
    }
  }
}
