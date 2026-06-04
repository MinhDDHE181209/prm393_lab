import 'package:flutter/material.dart';
import 'screens/movie_browsing_screen.dart'; // Import màn hình chính[cite: 3]

void main() {
  runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Movie Browser',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Tạo mã màu đồng bộ sang xịn mịn
      ),
      home: const MovieBrowsingScreen(), // Gọi màn hình duyệt phim từ thư mục screens[cite: 3]
    );
  }
}