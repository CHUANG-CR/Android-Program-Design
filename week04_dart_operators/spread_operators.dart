void main() {
  print('--- 1. 展開運算子 ... (Spread Operator) ---');
  var a = [1, 2, 3];
  var b = [0, a, 4];      // 沒有展開：變成巢狀 List
  var c = [0, ...a, 4];   // 使用 ...：將 a 的元素展開加入新 List

  print('未展開 b: $b'); // [0, [1, 2, 3], 4]
  print('展開後 c: $c'); // [0, 1, 2, 3, 4]

  print('\n--- 2. 空感知展開運算子 ...? (Null-aware Spread Operator) ---');
  List<int>? nullableList;
  // 若 nullableList 為 null，直接使用 ... 會拋出例外；使用 ...? 則會安全忽略
  var listWithNull = [0, ...?nullableList, 4];
  print('null 集合展開: $listWithNull'); // [0, 4]

  nullableList = [1, 2, 3];
  var listWithValue = [0, ...?nullableList, 4];
  print('有值時展開: $listWithValue'); // [0, 1, 2, 3, 4]
}
