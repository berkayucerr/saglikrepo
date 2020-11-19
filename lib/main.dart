import 'package:asistan_saglik/screens/genel_screen.dart';
import 'package:asistan_saglik/screens/girisekrani.dart';
import 'package:flutter/material.dart';

import 'nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Health', debugShowCheckedModeBanner: false, home: KayitGiris());
}
