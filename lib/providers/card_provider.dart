import 'package:flutter/material.dart';
import '../models/business_card.dart';

class CardProvider extends ChangeNotifier {
  final List<BusinessCard> _cards = [];

  List<BusinessCard> get cards => List.unmodifiable(_cards);

  void addCard(BusinessCard card) {
    _cards.add(card);
    notifyListeners();
  }

  void removeCard(String id) {
    _cards.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void updateCard(BusinessCard updated) {
    final idx = _cards.indexWhere((c) => c.id == updated.id);
    if (idx != -1) {
      _cards[idx] = updated;
      notifyListeners();
    }
  }

  void clearAll() {
    _cards.clear();
    notifyListeners();
  }
}
