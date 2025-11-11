class BusinessCard {
  String id;
  String name;        // 이름
  String company;     // 회사
  String position;    // 직급
  String phone;       // 전화번호
  String email;       // 이메일
  String imagePath;   // 이미지 경로
  List<String> categories; // 카테고리

  BusinessCard({
    required this.id,
    required this.name,
    required this.company,
    required this.position,
    required this.phone,
    required this.email,
    required this.imagePath,
    required this.categories,
  });
}
