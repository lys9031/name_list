import 'dart:io';
import 'package:flutter/material.dart';
import '../models/business_card.dart';

// 리스트 화면에서 한 장의 명함 카드를 꾸며주는 UI 위젯
class CardTile extends StatelessWidget {
  final BusinessCard card;
  CardTile({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: card.imagePath.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(File(card.imagePath), width: 60, height: 40, fit: BoxFit.cover),
        )
            : null,
        title: Text(card.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${card.company} | ${card.title}'),
        trailing: Text(card.categories.join(', '), style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
