import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/business_card.dart';
import '../utils/ocr_helper.dart';

class AddCardScreen extends StatefulWidget {
  final BusinessCard? card; // 수정 모드 지원

  AddCardScreen({this.card});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final companyCtrl = TextEditingController();
  final positionCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      nameCtrl.text = widget.card!.name;
      companyCtrl.text = widget.card!.company;
      positionCtrl.text = widget.card!.position;
      phoneCtrl.text = widget.card!.phone;
      emailCtrl.text = widget.card!.email;
      categoryCtrl.text = widget.card!.categories.join(', ');
      if (widget.card!.imagePath.isNotEmpty) {
        _imageFile = File(widget.card!.imagePath);
      }
    }
  }

  Future<void> _getImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });

      // OCR mock
      final ocr = await mockCardOCR();
      nameCtrl.text = ocr['name'] ?? nameCtrl.text;
      companyCtrl.text = ocr['company'] ?? companyCtrl.text;
      positionCtrl.text = ocr['position'] ?? positionCtrl.text;
      phoneCtrl.text = ocr['phone'] ?? phoneCtrl.text;
      emailCtrl.text = ocr['email'] ?? emailCtrl.text;
      categoryCtrl.text = ocr['category'] ?? categoryCtrl.text;
    }
  }

  void _saveCard() {
    if (_imageFile == null || nameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('사진과 이름은 필수입니다')));
      return;
    }
    final card = BusinessCard(
      id: widget.card?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameCtrl.text,
      company: companyCtrl.text,
      position: positionCtrl.text,
      phone: phoneCtrl.text,
      email: emailCtrl.text,
      imagePath: _imageFile!.path,
      categories: categoryCtrl.text.split(',').map((e) => e.trim()).toList(),
    );
    Navigator.pop(context, card);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.card == null ? '명함 추가' : '명함 수정')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            _imageFile == null
                ? ElevatedButton(onPressed: _getImage, child: Text('사진 촬영'))
                : Column(children: [
              Image.file(_imageFile!, width: 220, height: 140, fit: BoxFit.cover),
              SizedBox(height: 8),
              TextButton(onPressed: _getImage, child: Text('다시 촬영')),
            ]),
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: '이름')),
            TextField(controller: companyCtrl, decoration: InputDecoration(labelText: '회사')),
            TextField(controller: positionCtrl, decoration: InputDecoration(labelText: '직급')),
            TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: '전화번호')),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: '이메일')),
            TextField(controller: categoryCtrl, decoration: InputDecoration(labelText: '카테고리(,로 구분)')),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: _saveCard,
                child: Text(widget.card == null ? '저장' : '수정 완료'))
          ],
        ),
      ),
    );
  }
}
