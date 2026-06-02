import 'package:flutter/material.dart';
import 'core_widgets_demo.dart'; // Import file vừa tạo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Exercise 1',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CoreWidgetsDemo(), // Chạy trực tiếp màn hình bài 1
    );
  }
}