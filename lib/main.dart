import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// 앱의 시작점
void main() {
  runApp(NameListApp());
}

class NameListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '명함함',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomeScreen(),
    );
  }
}
