import 'package:flutter/material.dart';
import 'receipt_model.dart';

class EditReceiptPage extends StatefulWidget {
  final Receipt receipt;
  const EditReceiptPage({super.key, required this.receipt});

  @override
  State<EditReceiptPage> createState() => _EditReceiptPageState();
}

class _EditReceiptPageState extends State<EditReceiptPage> {
  late TextEditingController storeController;
  late TextEditingController dateController;
  late TextEditingController totalController;
  late TextEditingController vatController;
  late TextEditingController approvalController;
  late TextEditingController payController;
  late TextEditingController memoController;

  @override
  void initState() {
    super.initState();
    storeController = TextEditingController(text: widget.receipt.storeName);
    dateController = TextEditingController(text: widget.receipt.dateTime);
    totalController = TextEditingController(text: widget.receipt.totalAmount);
    vatController = TextEditingController(text: widget.receipt.vatAmount);
    approvalController = TextEditingController(text: widget.receipt.approvalNo);
    payController = TextEditingController(text: widget.receipt.payMethod);
    memoController = TextEditingController(text: widget.receipt.memo);
  }

  @override
  void dispose() {
    storeController.dispose();
    dateController.dispose();
    totalController.dispose();
    vatController.dispose();
    approvalController.dispose();
    payController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('영수증 정보 수정')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField('상호명', storeController),
            _buildField('일시', dateController),
            _buildField('총액', totalController),
            _buildField('부가세', vatController),
            _buildField('승인번호', approvalController),
            _buildField('결제수단', payController),
            _buildField('메모', memoController, maxLines: 3),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: 로컬 DB에 저장할 경우 로직 추가
                Navigator.pop(context, widget.receipt);
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
