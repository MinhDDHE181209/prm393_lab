import 'package:flutter/material.dart';
import 'screens/signup_screen.dart'; // Import file xử lý Form đăng ký

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 7 - Form Validation',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SignupScreen(), // Thiết lập màn hình đăng ký làm trang chính
    );
  }
}