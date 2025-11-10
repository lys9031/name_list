import 'dart:io';
import 'package:flutter/material.dart';
import '../models/business_card.dart';
import 'add_card_screen.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';

class DetailScreen extends StatelessWidget {
  final BusinessCard card;

  DetailScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    // 카드 정보가 삭제/수정됐을 수 있으므로 최신값으로 찾기
    final provider = context.watch<CardProvider>();
    final fresh = provider.cards.firstWhere((c) => c.id == card.id, orElse: () => card);

    return Scaffold(
      appBar: AppBar(
        title: Text(fresh.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final edited = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddCardScreen(card: fresh), // 기존 정보 전달
                ),
              );
              if (edited != null) {
                provider.updateCard(edited);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("명함 정보가 수정되었습니다.")),
                );
              }
            },
            tooltip: "수정",
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fresh.imagePath.isNotEmpty)
              Center(
                child: Image.file(File(fresh.imagePath), width: 220, height: 140, fit: BoxFit.cover),
              ),
            SizedBox(height: 20),
            Text('이름: ${fresh.name}', style: TextStyle(fontSize: 20)),
            Text('회사: ${fresh.company}'),
            Text('직급: ${fresh.position}'),
            Text('전화번호: ${fresh.phone}'),
            Text('이메일: ${fresh.email}'),
            Text('카테고리: ${fresh.categories.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
