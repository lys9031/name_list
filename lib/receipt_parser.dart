import 'receipt_model.dart';

Receipt parseReceipt(String text) {
  // 모든 줄을 분리
  final lines = text.split('\n').where((line) => line.trim().isNotEmpty).toList();

  String storeName = lines.isNotEmpty ? lines.first.trim() : '';
  String dateTime = '';
  String totalAmount = '';
  String vatAmount = '';
  String approvalNo = '';
  String payMethod = '';
  String memo = '';

  // 정규식 패턴 예시
  final dateReg = RegExp(r'20\d{2}[./-]\d{1,2}[./-]\d{1,2}');
  final totalReg = RegExp(r'(총액|합계|결제금액)\s*[\d,]+');
  final vatReg = RegExp(r'(부가세|세액)\s*[\d,]+');
  final approvalReg = RegExp(r'승인(?:번호)?\s*[\d-]+');

  for (final line in lines) {
    if (dateTime.isEmpty && dateReg.hasMatch(line)) {
      dateTime = dateReg.firstMatch(line)!.group(0)!;
    }
    if (totalAmount.isEmpty && totalReg.hasMatch(line)) {
      totalAmount = totalReg.firstMatch(line)!.group(0)!.replaceAll(RegExp(r'[^0-9,]'), '');
    }
    if (vatAmount.isEmpty && vatReg.hasMatch(line)) {
      vatAmount = vatReg.firstMatch(line)!.group(0)!.replaceAll(RegExp(r'[^0-9,]'), '');
    }
    if (approvalNo.isEmpty && approvalReg.hasMatch(line)) {
      approvalNo = approvalReg.firstMatch(line)!.group(0)!;
    }
  }

  // 기본값 처리
  return Receipt(
    storeName: storeName,
    dateTime: dateTime,
    totalAmount: totalAmount,
    vatAmount: vatAmount,
    approvalNo: approvalNo,
    payMethod: payMethod,
    memo: memo,
  );
}
