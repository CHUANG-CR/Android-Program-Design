import 'package:http/http.dart' as http;

/// 非同步函式：透過 HTTP GET 獲取 Wikipedia 摘要資料
Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  // await 會等待 HTTP 請求完成，而不阻斷主執行緒
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body; // 請求成功，回傳回應本文 (JSON 格式)
  }

  // 請求失敗時回傳錯誤訊息
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}

void main() async {
  print('正在查詢 Wikipedia: Dart_(programming_language)...');
  final articleContent = await getWikipediaArticle("Dart_(programming_language)");
  print('\n[回應結果]:');
  print(articleContent);
}
