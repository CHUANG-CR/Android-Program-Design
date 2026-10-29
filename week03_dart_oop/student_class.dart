/// 1. 基本類別定義
class SimpleStudent {
  SimpleStudent(this.name, this.no);

  final String name;
  final String no;
}

/// 2. 具名參數與 3. Getter 函式
class Student {
  // 建構子使用具名參數，其中 no 為必填 (required)
  Student(this.name, {required this.no});

  final String name;
  final String? no;

  // Getter 屬性計算
  String get nameNo {
    return '$name: $no';
  }

  @override
  String toString() => 'Student(name: $name, no: $no)';
}

void main() {
  print('--- 1. 基本類別與建構子 ---');
  final simple = SimpleStudent("John", "123456");
  print(simple);
  print('${simple.name}${simple.no}');

  print('\n--- 2. 具名參數 ---');
  final student1 = Student("John", no: "1234");
  print(student1);
  print(student1.name + (student1.no ?? ""));

  print('\n--- 3. Getter 存取器 ---');
  print('Getter nameNo 結果: ${student1.nameNo}');
}
