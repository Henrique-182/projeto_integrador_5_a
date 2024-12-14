import 'package:flutter/material.dart';
import 'package:projeto_integrador_5_a/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: MainPage(),
    );
  }  
}
