import 'dart:io';
import 'package:flutter/material.dart';
import '../models/business_card.dart';

class CardTile extends StatelessWidget {
  final BusinessCard card;
  final void Function()? onDelete;

  CardTile({required this.card, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(card.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (onDelete != null) onDelete!();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${card.name} 명함이 삭제되었습니다.')),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${card.company} | ${card.position}'),
              Text('☎ ${card.phone}'),
              Text('✉ ${card.email}'),
            ],
          ),
          trailing: Text(card.categories.join(', '), style: TextStyle(color: Colors.blue)),
        ),
      ),
    );
  }
}
