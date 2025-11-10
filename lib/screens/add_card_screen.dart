import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/business_card.dart';
import '../utils/ocr_helper.dart';

// 명함 추가 화면 (카메라로 사진, OCR 인식, 직접 입력)
class AddCardScreen extends StatefulWidget {
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final companyCtrl = TextEditingController();
  final titleCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();

  Future<void> _getImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });

      // OCR mock: 실제는 ocr_helper.dart 참고
      final ocr = await mockCardOCR();
      nameCtrl.text = ocr['name'] ?? '';
      companyCtrl.text = ocr['company'] ?? '';
      titleCtrl.text = ocr['title'] ?? '';
      categoryCtrl.text = ocr['category'] ?? '';
    }
  }

  void _saveCard() {
    if (_imageFile == null || nameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('사진과 이름은 필수입니다')));
      return;
    }
    final card = BusinessCard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameCtrl.text,
      company: companyCtrl.text,
      title: titleCtrl.text,
      imagePath: _imageFile!.path,
      categories: categoryCtrl.text.split(',').map((e) => e.trim()).toList(),
    );
    Navigator.pop(context, card);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('명함 추가')),
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
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: '직함')),
            TextField(controller: categoryCtrl, decoration: InputDecoration(labelText: '카테고리(,로 구분)')),
            SizedBox(height: 24),
            ElevatedButton(onPressed: _saveCard, child: Text('저장'))
          ],
        ),
      ),
    );
  }
}
