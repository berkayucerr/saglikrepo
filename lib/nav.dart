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
            title: Text('Home'),
            icon: Icon(Icons.home),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Spor'),
            icon: Icon(Icons.sports),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Diyet'),
            icon: Icon(Icons.calendar_today),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Rapor'),
            icon: Icon(Icons.report),
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Profil'),
            icon: Icon(Icons.person),
            backgroundColor: Colors.orange)
      ], currentIndex: _selectedIndex, onTap: _onItemTap),
    );
  }
}
