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
                  builder: (_) => AddCardScreen(card: fresh),
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
        child: Center(
          child: Hero(
            tag: "card_${fresh.id}",
            child: Container(
              padding: EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 32,
                    spreadRadius: 5,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (fresh.imagePath.isNotEmpty)
                    Center(
                      child: Image.file(File(fresh.imagePath), width: 220, height: 140, fit: BoxFit.cover),
                    ),
                  SizedBox(height: 20),
                  Text('이름: ${fresh.name}', style: Theme.of(context).textTheme.titleLarge),
                  Text('회사: ${fresh.company}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('직급: ${fresh.position}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('전화번호: ${fresh.phone}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('이메일: ${fresh.email}', style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: fresh.categories.map((cat) => Chip(
                      label: Text(cat),
                      backgroundColor: Colors.orange[200],
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
