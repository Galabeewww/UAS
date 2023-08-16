import 'package:flutter/material.dart';
import 'package:abiw_tes1/index.dart';
import 'package:abiw_tes1/char.dart';
import 'package:abiw_tes1/series.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MainScreen(), // Ganti dengan nama halaman
    CharScreen(), // Ganti dengan nama halaman
    SeriesScreen(), // Ganti dengan nama halaman
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Character"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Series"),
        ],
      ),
    );
  }
}
