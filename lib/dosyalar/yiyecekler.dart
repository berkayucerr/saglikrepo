import 'package:flutter/cupertino.dart';

class yiyecekler {
  int id = 0;
  bool value = false;
  String isim = "";
  int kalori = 0;
  yiyecekler(int _id, String _isim, int _kalori) {
    this.id = _id;
    this.isim = _isim;
    this.kalori = _kalori;
    //veritabanı kodu gelecek
  }
}
