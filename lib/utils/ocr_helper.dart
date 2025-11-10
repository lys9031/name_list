// 실제로는 ML Kit 등 연동, 지금은 mock(더미)
Future<Map<String, String>> mockCardOCR() async {
  await Future.delayed(Duration(seconds: 1));
  return {
    'name': '홍길동',
    'company': '오픈AI',
    'title': 'AI개발자',
    'category': 'IT, AI'
  };
}
