/// 範例 1：可空參數與 ?. (條件成員存取運算子)
void searchWikipedia(List<String>? arguments) {
  // arguments 可能是 null，使用 arguments?.first 可避免 NoSuchMethodError / NullPointerException
  print('searchWikipedia received arguments: $arguments');
  print('First argument: ${arguments?.first}');
}

void main() {
  print('--- 1. Null Safety 參數傳遞 ---');
  searchWikipedia(['stust', 'csie']);
  searchWikipedia(null);

  print('\n--- 2. 可空變數宣告 ---');
  int? score;
  print('初始 score: $score'); // null
  score = 100;
  print('賦值後 score: $score'); // 100

  print('\n--- 3. ?? 空值合併運算子 (Null-coalescing Operator) ---');
  int? unassignedScore;
  // 若 unassignedScore 為 null，則使用預設值 110
  int addScore = unassignedScore ?? 110;
  print('addScore (使用預設值): $addScore');

  unassignedScore = 60;
  addScore = unassignedScore ?? 110;
  print('addScore (有值時): $addScore');
}
