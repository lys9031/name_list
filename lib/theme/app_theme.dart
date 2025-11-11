import 'package:flutter/material.dart';

// 파스텔 컬러 팔레트
final pastelColors = [
  Color(0xFFFFAA70), // 오렌지
  Color(0xFFFFD9C2), // 살구
  Color(0xFFA9D3B7), // 민트
  Color(0xFFFF7360), // 코랄
  Color(0xFF57B894), // 포인트 그린
];

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Pretendard',
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFFFF7F0),
  colorScheme: ColorScheme.light(
    primary: Color(0xFFFFAA70),
    secondary: Color(0xFFA9D3B7),
    background: Color(0xFFFFF7F0),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
    iconTheme: IconThemeData(color: Color(0xFF5A504A)),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF2C2826)
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 38, color: Color(0xFF2C2826)),
    titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Color(0xFF2C2826)),
    titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF5A504A)),
    bodyLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF5A504A)),
    bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey[700]),
    labelLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFFFFAA70)),
    labelSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey[500]),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    hintStyle: TextStyle(color: Colors.grey[400]),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFAA70),
    foregroundColor: Colors.white,
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFFFAA70),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      elevation: 5,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Color(0xFFFFD9C2),
    disabledColor: Colors.grey[200]!,
    selectedColor: Color(0xFFFFAA70),
    secondarySelectedColor: Color(0xFF57B894),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    labelStyle: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
    secondaryLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
