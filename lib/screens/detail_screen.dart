import 'dart:io';
import 'package:flutter/material.dart';
import '../models/business_card.dart';

// 명함 상세 정보 보기 화면
class DetailScreen extends StatelessWidget {
  final BusinessCard card;

  DetailScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(card.name)),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (card.imagePath.isNotEmpty)
              Center(
                child: Image.file(File(card.imagePath), width: 220, height: 140, fit: BoxFit.cover),
              ),
            SizedBox(height: 20),
            Text('이름: ${card.name}', style: TextStyle(fontSize: 20)),
            Text('회사: ${card.company}'),
            Text('직함: ${card.title}'),
            Text('카테고리: ${card.categories.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
