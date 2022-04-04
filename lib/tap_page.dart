import 'package:flutter/material.dart';
import 'package:instargram_clone/search_page.dart';
import 'package:instargram_clone/account_page.dart';
import 'package:instargram_clone/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabPage extends StatefulWidget {
  final User? user;

  const TabPage(this.user, {Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  List? _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Homepage(widget.user),
      SearchPage(widget.user),
      const Text('page3'),
      const Text('page4'),
      AccountPage(widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages?[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video), label: 'Video'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'Shop'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
