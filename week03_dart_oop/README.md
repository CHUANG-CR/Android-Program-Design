# Week 3: Dart 物件導向程式設計 (Object-Oriented Programming)

官方教學：[Dart Object-Oriented Tutorial](https://dart.dev/learn/tutorial/object-oriented)

本週重點為 Dart 的物件導向核心概念：類別定義、精簡建構子、具名參數、Getter 存取器、抽象類別、繼承與多型應用。

---

## 1. 類別定義與精簡建構子

參考程式碼：[`student_class.dart`](./student_class.dart)

Dart 支援直接在建構子參數中使用 `this.fieldName`，省去冗長的賦值代碼：
```dart
class Student {
  final String name;
  final String no;

  // 語法糖建構子：自動將傳入的參數指派給成員變數
  Student(this.name, this.no);
}
```

---

## 2. 具名參數 (Named Parameters) 與 `required`

Dart 建構子支援大括號 `{}` 包裹的具名參數，在呼叫時透過 `名稱: 數值` 指定，大幅提升程式碼可讀性：
```dart
class Student {
  final String name;
  final String? no;

  // name 為位置參數，no 為具名參數且為必填 (required)
  Student(this.name, {required this.no});
}

// 呼叫方式：
final s = Student("John", no: "1234");
```

---

## 3. Getter 屬性存取器

使用 `get` 關鍵字可以宣告如同屬性般存取的計算方法：
```dart
String get nameNo {
  return '$name: $no';
}

// 存取時不需要加小括號 ()
print(student1.nameNo);
```

---

## 4. 抽象類別 (Abstract Class) 與繼承 (Inheritance)

參考程式碼：[`animal_polymorphism.dart`](./animal_polymorphism.dart)

- **抽象類別**：使用 `abstract` 關鍵字，不可直接被 `new` / 實例化，主要作為基底規範。
- **抽象方法**：只宣告方法簽名，不提供方法體（以 `;` 結尾）。
- **子類別繼承**：使用 `extends`，並使用 `: super(...)` 呼叫父類別建構子。
- **方法覆寫**：加上 `@override` 標註以確保正確改寫父類別行為。

```dart
abstract class Animal {
  String name;
  Animal(this.name);

  // 抽象方法
  void sound();
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void sound() {
    print('$name：汪汪！');
  }
}
```

---

## 5. 多型 (Polymorphism) 實踐

宣告集合型態為父類別 `List<Animal>`，可以同時容納各個不同的子類別物件，並透過統一的介面 `sound()` 觸發個別子類別的多型實作：
```dart
List<Animal> animals = [
  Dog('小黑'),
  Cat('小花'),
  Cat('小A'),
  Cat('小B'),
];

for (var animal in animals) {
  animal.sound(); // 自動調用各自的 sound()
}
```

### 執行方式
```bash
dart run week03_dart_oop/student_class.dart
dart run week03_dart_oop/animal_polymorphism.dart
```
