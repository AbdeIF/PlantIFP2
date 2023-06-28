import 'package:flutter/material.dart';
import 'TelaCarregamento.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaCarregamento(),
    );
  }
}
