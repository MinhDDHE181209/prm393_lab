import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart'; // Import màn hình danh sách bài viết

void main() {
  runApp(const ApiListApp());
}

class ApiListApp extends StatelessWidget {
  const ApiListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt nhãn DEBUG màu đỏ
      title: 'Lab 8 - REST API Integration',
      theme: ThemeData(
        useMaterial3: true, // Áp dụng Material Design 3 mới nhất cho đồng bộ hệ thống
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const PostListScreen(), // Đặt màn hình PostList làm trang chủ của app
    );
  }
}