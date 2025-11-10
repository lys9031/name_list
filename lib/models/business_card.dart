// BusinessCard 클래스 - 명함 1장의 데이터 구조
class BusinessCard {
  String id;
  String name;
  String company;
  String title;
  String imagePath;
  List<String> categories;

  BusinessCard({
    required this.id,
    required this.name,
    required this.company,
    required this.title,
    required this.imagePath,
    required this.categories,
  });
}
