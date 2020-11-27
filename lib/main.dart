import 'package:asistan_saglik/screens/girisekrani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('steps');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null)
      return MaterialApp(
          title: 'Health',
          debugShowCheckedModeBanner: false,
          home: KayitGiris());
    else
      return MaterialApp(
          title: 'Health', debugShowCheckedModeBanner: false, home: Home());
  }
}
