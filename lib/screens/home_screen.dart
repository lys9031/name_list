import 'package:flutter/material.dart';
import '../models/business_card.dart';
import 'add_card_screen.dart';
import 'detail_screen.dart';
import '../widgets/card_tile.dart';

// 명함 리스트 화면: 모든 명함을 스크롤로 보여줌
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BusinessCard> cardList = [];

  void addNewCard(BusinessCard card) {
    setState(() {
      cardList.add(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('명함 리스트')),
      body: cardList.isEmpty
          ? Center(child: Text('저장된 명함이 없습니다.'))
          : ListView.builder(
        itemCount: cardList.length,
        itemBuilder: (context, idx) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(card: cardList[idx]),
              ),
            ),
            child: CardTile(card: cardList[idx]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCard = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddCardScreen(),
            ),
          );
          if (newCard != null) addNewCard(newCard);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
