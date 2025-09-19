class Receipt {
  String storeName;
  String dateTime;
  String totalAmount;
  String vatAmount;
  String approvalNo;
  String payMethod;
  String memo;

  Receipt({
    required this.storeName,
    required this.dateTime,
    required this.totalAmount,
    required this.vatAmount,
    required this.approvalNo,
    required this.payMethod,
    required this.memo,
  });
}
