import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          // 將初始的 'Hello World!' 修改為 'Hello Stust!!'
          child: Text('Hello Stust!!'),
        ),
      ),
    );
  }
}
