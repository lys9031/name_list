Future<Map<String, String>> mockCardOCR() async {
  await Future.delayed(Duration(seconds: 1));
  return {
    'name': '홍길동',
    'company': '오픈AI',
    'position': '팀장',
    'phone': '010-1234-5678',
    'email': 'honggildong@openai.com',
    'category': 'IT, AI'
  };
}
