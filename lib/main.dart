import 'package:flutter/material.dart';
import './user/user.dart';
import './home/home.dart';
import './nav/nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Home')),
          backgroundColor: Colors.grey[850],
        ),
        body: HomePage(),
        // body: UserPage(),
        bottomNavigationBar: const Navbar(),
      ),
    );
  }
}
