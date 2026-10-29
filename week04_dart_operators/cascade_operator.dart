/// Cascade (級聯) 運算子範例
class Person {
  String? name;
  int? age;

  void sayHello() {
    print('hello: $name, $age');
  }
}

void main() {
  print('--- 傳統逐步操作 ---');
  var person1 = Person();
  person1.name = 'Tom';
  person1.age = 20;
  person1.sayHello();

  print('\n--- 使用 .. 級聯運算子 (Cascade) ---');
  // .. 會在同一個物件上連續執行多個操作，最後回傳該物件本身
  var person2 = Person()
    ..name = 'Tom'
    ..age = 20
    ..sayHello();

  print('person2 建立成功: name=${person2.name}, age=${person2.age}');
}
