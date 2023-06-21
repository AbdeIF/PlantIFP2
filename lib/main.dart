import 'package:flutter/material.dart';
import 'package:plantifpi/scanner.dart';
import 'TelaCarregamento.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaCarregamento(),
    );
  }
}