/// 4. 抽象類別：定義共通介面與規範，不可直接被實例化
abstract class Animal {
  String name;
  Animal(this.name);

  // 抽象方法：只有宣告，沒有實作內容
  void sound();
}

/// 繼承 Animal，透過 super(name) 呼叫父類別建構子
class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void sound() {
    print('$name：汪汪！');
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void sound() {
    print('$name：喵喵！');
  }
}

void main() {
  print('--- 單一物件呼叫 ---');
  Dog dog = Dog('小黑');
  Cat cat = Cat('小花');
  dog.sound();
  cat.sound();

  print('\n--- 5. 多型範例：宣告變數型態為父類別 Animal ---');
  List<Animal> animals = [
    Dog('小黑'),
    Cat('小花'),
    Cat('小A'),
    Cat('小B'),
  ];

  for (var animal in animals) {
    animal.sound();
  }
}
