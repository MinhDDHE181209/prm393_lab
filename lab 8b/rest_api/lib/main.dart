import 'package:flutter/material.dart';
import 'screens/movie_explorer_screen.dart';

void main() {
  runApp(const MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  const MovieExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8B - Movie Companion Explorer',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark, // Chuyển giao diện toàn app sang Dark Mode huyền bí
      ),
      home: const MovieExplorerScreen(),
    );
  }
}