import 'package:asistan_saglik/screens/girisekrani.dart';
import 'package:flutter/material.dart';
import 'package:asistan_saglik/nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Health',
        home: KayitGiris(),
        debugShowCheckedModeBanner: false,
      );
}
