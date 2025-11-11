import 'dart:io';
import 'package:flutter/material.dart';
import '../models/business_card.dart';
import '../theme/app_theme.dart';

class AnimatedCardTile extends StatelessWidget {
  final BusinessCard card;
  final void Function()? onDelete;
  final Animation<double>? animation;
  final VoidCallback? onTap;

  AnimatedCardTile({required this.card, this.onDelete, this.animation, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = pastelColors[card.name.hashCode % pastelColors.length];

    Widget cardBody = GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: "card_${card.id}",
        child: AnimatedContainer(
          duration: Duration(milliseconds: 320),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.98),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.12),
                blurRadius: 18, spreadRadius: 3, offset: Offset(0, 6),
              ),
            ],
            border: Border.all(color: color.withOpacity(0.22), width: 1),
          ),
          child: ListTile(
            leading: card.imagePath.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(File(card.imagePath), width: 64, height: 44, fit: BoxFit.cover),
            )
                : Container(
              width: 52, height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.11),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.person, color: color, size: 28),
            ),
            title: Text(card.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${card.company} | ${card.position}", style: TextStyle(fontSize: 15)),
                Text("☎ ${card.phone}   ✉ ${card.email}", style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                SizedBox(height: 3),
                Wrap(
                  spacing: 6,
                  children: card.categories.map((cat) => Chip(
                    label: Text(cat, style: TextStyle(color: Colors.white, fontSize: 12)),
                    backgroundColor: pastelColors[cat.hashCode % pastelColors.length].withOpacity(0.7),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  )).toList(),
                ),
              ],
            ),
            trailing: onDelete != null
                ? IconButton(icon: Icon(Icons.delete_forever_rounded, color: color), onPressed: onDelete)
                : null,
          ),
        ),
      ),
    );

    if (animation != null) {
      return FadeTransition(
        opacity: animation!,
        child: SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 0.15), end: Offset.zero).animate(animation!),
          child: cardBody,
        ),
      );
    }
    return cardBody;
  }
}
