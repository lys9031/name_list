import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/card_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart'; // 커스텀 테마만 적용

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CardProvider(),
      child: NameListApp(),
    ),
  );
}

class NameListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '명함함',
      debugShowCheckedModeBanner: false, // debug 리본 제거
      theme: appTheme,    // 라이트 테마만 적용
      home: HomeScreen(), // 앱 메인화면
    );
  }
}
