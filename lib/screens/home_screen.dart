import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import 'add_card_screen.dart';
import 'detail_screen.dart';
import '../widgets/card_tile.dart';
import '../models/business_card.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  String? _selectedCategory;
  String _sortOption = 'latest';
  bool _sampleAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_sampleAdded) {
      final provider = context.read<CardProvider>();
      if (provider.cards.isEmpty) {
        for (final card in sampleCards) {
          provider.addCard(card);
        }
      }
      _sampleAdded = true;
    }
  }

  // 샘플 명함 데이터 리스트 (업데이트된 구조)
  final sampleCards = [
    BusinessCard(
      id: Random().nextInt(999999).toString(),
      name: "홍길동",
      company: "오픈AI",
      position: "AI 개발자",
      phone: "010-1234-5678",
      email: "honggildong@openai.com",
      imagePath: "",
      categories: ["IT", "AI"],
    ),
    BusinessCard(
      id: Random().nextInt(999999).toString(),
      name: "김철수",
      company: "삼성전자",
      position: "연구원",
      phone: "010-1111-2222",
      email: "kim@ss.com",
      imagePath: "",
      categories: ["전자", "연구"],
    ),
    BusinessCard(
      id: Random().nextInt(999999).toString(),
      name: "이영희",
      company: "카카오",
      position: "마케팅 매니저",
      phone: "010-3333-4444",
      email: "lee@kakao.com",
      imagePath: "",
      categories: ["마케팅"],
    ),
    BusinessCard(
      id: Random().nextInt(999999).toString(),
      name: "Alex Johnson",
      company: "Naver",
      position: "Designer",
      phone: "010-5555-6666",
      email: "alex@naver.com",
      imagePath: "",
      categories: ["디자인", "IT"],
    ),
    BusinessCard(
      id: Random().nextInt(999999).toString(),
      name: "최지민",
      company: "현대자동차",
      position: "기획팀장",
      phone: "010-7777-8888",
      email: "choi@hyundai.com",
      imagePath: "",
      categories: ["자동차", "기획"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cardProvider = context.watch<CardProvider>();
    final cards = cardProvider.cards;

    final allCategories = cards.expand((c) => c.categories).toSet().toList();

    final filtered = cards.where((card) {
      final q = _query.toLowerCase();
      final queryMatch = _query.isEmpty ||
          card.name.toLowerCase().contains(q) ||
          card.company.toLowerCase().contains(q) ||
          card.position.toLowerCase().contains(q) ||
          card.phone.toLowerCase().contains(q) ||
          card.email.toLowerCase().contains(q) ||
          card.categories.any((cat) => cat.toLowerCase().contains(q));
      final categoryMatch = _selectedCategory == null ||
          card.categories.contains(_selectedCategory!);
      return queryMatch && categoryMatch;
    }).toList();

    filtered.sort((a, b) {
      if (_sortOption == 'latest') return b.id.compareTo(a.id);
      if (_sortOption == 'name') return a.name.compareTo(b.name);
      return 0;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('명함 리스트'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '이름, 회사, 직급, 전화번호, 이메일, 카테고리로 검색',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _query = value.trim();
                    });
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ActionChip(
                      label: Text('전체'),
                      onPressed: () => setState(() => _selectedCategory = null),
                      backgroundColor: _selectedCategory == null ? Colors.blue : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: _selectedCategory == null ? Colors.white : Colors.black,
                      ),
                    ),
                    ...allCategories.map((cat) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ActionChip(
                        label: Text(cat),
                        onPressed: () => setState(() => _selectedCategory = cat),
                        backgroundColor: _selectedCategory == cat ? Colors.blue : Colors.grey[200],
                        labelStyle: TextStyle(
                          color: _selectedCategory == cat ? Colors.white : Colors.black,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 16, right: 16, bottom: 4),
                child: Row(
                  children: [
                    Text('정렬:', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _sortOption,
                      onChanged: (val) => setState(() => _sortOption = val!),
                      items: [
                        DropdownMenuItem(child: Text('최신순'), value: 'latest'),
                        DropdownMenuItem(child: Text('이름순'), value: 'name'),
                      ],
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: filtered.isEmpty
          ? Center(child: Text('검색 결과가 없습니다.'))
          : ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, idx) {
          final card = filtered[idx];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(card: card),
              ),
            ),
            child: CardTile(
              card: card,
              onDelete: () => cardProvider.removeCard(card.id),
            ),
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
          if (newCard != null) {
            context.read<CardProvider>().addCard(newCard);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
