# Week 4: Dart 特殊運算子 (Cascade & Spread)

本週介紹 Dart 中能大幅簡化代碼、提升流暢度的特殊運算子：**級聯運算子 (`..`)** 與 **集合展開運算子 (`...` / `...?`)**。

---

## 1. 級聯運算子 (`..` Cascade Operator)

參考程式碼：[`cascade_operator.dart`](./cascade_operator.dart)

- **概念**：允許你對同一個物件連續呼叫多個成員方法或設定成員屬性，運算結束後回傳該物件本身。
- **好處**：不需要宣告臨時變數，能以鏈式風格 (Fluent API) 組織代碼。

```dart
// 傳統寫法：
var person1 = Person();
person1.name = 'Tom';
person1.age = 20;
person1.sayHello();

// 使用級聯運算子 .. ：
var person2 = Person()
  ..name = 'Tom'
  ..age = 20
  ..sayHello();
```
> [!NOTE]
> 在 Flutter 中，級聯運算子經常被用在物件初始設定、繪製 Canvas (`Path` 操作) 等情境。

---

## 2. 展開運算子 (`...` Spread Operator)

參考程式碼：[`spread_operators.dart`](./spread_operators.dart)

- **概念**：將一個集合 (List / Set / Map) 的所有元素直接「展開」到另一個集合之中。
```dart
var a = [1, 2, 3];
var b = [0, a, 4];    // 結果：[0, [1, 2, 3], 4]  (巢狀結構)
var c = [0, ...a, 4]; // 結果：[0, 1, 2, 3, 4]    (平坦展開)
```

---

## 3. 空感知展開運算子 (`...?` Null-aware Spread Operator)

- **概念**：如果被展開的集合可能是 `null`，使用 `...` 會拋出例外；而使用 `...?` 則會安全地略過 `null`，不影響外層集合的建構。
```dart
List<int>? a;
var b = [0, ...?a, 4]; // 結果：[0, 4] (a 為 null，自動略過)

a = [1, 2, 3];
var c = [0, ...?a, 4]; // 結果：[0, 1, 2, 3, 4]
```

### 執行方式
```bash
dart run week04_dart_operators/cascade_operator.dart
dart run week04_dart_operators/spread_operators.dart
```
