import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import màn hình danh sách chính

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt cái banner DEBUG màu đỏ ở góc phải
      title: 'Movie Detail App',
      theme: ThemeData(
        useMaterial3: true, // Sử dụng Material Design 3 mới nhất cho giao diện hiện đại
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(), // Đặt HomeScreen làm màn hình khởi đầu của app
    );
  }
}