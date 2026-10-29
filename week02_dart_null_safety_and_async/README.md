# Week 2: Dart 空安全 (Null Safety) 與非同步程式設計 (async / await)

本週重點為 Dart 的現代核心語法：健全空安全 (Sound Null Safety) 系統，以及處理網路請求時必備的非同步 (Asynchronous) 程式設計。

---

## 1. 空安全運算子 (Null Safety Operators)

參考程式碼：[`null_safety.dart`](./null_safety.dart)

### (1) `?` 型態修飾 (Nullable Type)
Dart 預設所有變數皆為 **Non-nullable**（不可為 null）。若允許變數或參數為空，須在型態後方加上 `?`：
```dart
int? score; // 可以存放整數，也可以是 null（初始值預設為 null）
List<String>? arguments; // 傳入的 List 可以是 null
```

### (2) `?.` 條件成員存取 (Null-aware Method/Property Invocation)
當物件可能為 `null` 時，使用 `?.` 可以避免擲出例外：
```dart
// 若 arguments 為 null，整個表達式回傳 null，而不會崩潰
print(arguments?.first);
```

### (3) `??` 空值合併運算子 (If-null / Null-coalescing Operator)
若運算子左側為 `null`，則回傳右側的預設值；否則回傳左側值：
```dart
int? score;
int finalScore = score ?? 110; // score 為 null，因此 finalScore 為 110
```

---

## 2. 非同步程式設計 (async / await & HTTP)

參考程式碼：[`async_wikipedia.dart`](./async_wikipedia.dart)

Dart 是單執行緒事件循環（Event Loop）模型。對於網路請求、檔案 I/O 等耗時操作，使用 `Future`、`async` 與 `await` 避免阻塞主執行緒。

### 範例解說：透過 Wikipedia REST API 獲取資料
```dart
import 'package:http/http.dart' as http;

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  // await 會暫停當前函式執行，直到非同步操作完成並回傳 Response 物件
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body; // 回傳 JSON 字串
  }
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}

void main() async {
  var articleContent = await getWikipediaArticle("Dart_(programming_language)");
  print(articleContent);
}
```

### 執行方式
```bash
cd week02_dart_null_safety_and_async
dart pub get
dart run null_safety.dart
dart run async_wikipedia.dart
```
