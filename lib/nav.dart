import 'package:flutter/material.dart';
import 'screens/diyet_screen.dart';
import 'screens/genel_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/rapor_screen.dart';
import 'screens/spor_screen.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Genel(),
    Spor(),
    Diyet(),
    Rapor(),
    Profil(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange, title: Text('Health')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Home Ekranı'),
            icon: Icon(Icons.home),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Spor Ekranı'),
            icon: Icon(Icons.sports),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Diyet Ekranı'),
            icon: Icon(Icons.calendar_today),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Rapor Ekranı'),
            icon: Icon(Icons.report),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Profil Ekranı'),
            icon: Icon(Icons.person),
            backgroundColor: Colors.orange)
      ], currentIndex: _selectedIndex, onTap: _onItemTap),
    );
  }
}
