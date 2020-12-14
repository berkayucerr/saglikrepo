import 'package:flutter/material.dart';
import '../diyet/diyet_screen.dart';
import '../home/genel_screen.dart';
import '../profil/profil_screen.dart';
import '../report/report_screen.dart';
import '../Spor/spor_screen.dart';

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
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Home Ekranı'),
                icon: Icon(Icons.home),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Spor Ekranı'),
                icon: Icon(Icons.sports),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Diyet Ekranı'),
                icon: Icon(Icons.calendar_today),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Rapor Ekranı'),
                icon: Icon(Icons.report),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text('Profil Ekranı'),
                icon: Icon(Icons.person),
                backgroundColor: Colors.black),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap),
    );
  }
}
