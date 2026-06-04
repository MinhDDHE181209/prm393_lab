import 'package:flutter/material.dart';

class ThemeDemo extends StatelessWidget {
  final Function(bool) toggleTheme;
  final ThemeMode currentThemeMode;

  const ThemeDemo({super.key, required this.toggleTheme, required this.currentThemeMode});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = currentThemeMode == ThemeMode.dark;

    return Scaffold( // Sử dụng đầy đủ cấu trúc Scaffold [cite: 45]
      appBar: AppBar(
        title: const Text('Exercise 4 – App Str...'),
        actions: [
          Row(
            children: [
              const Text("Dark"),
              Switch(
                value: isDarkMode,
                onChanged: (value) => toggleTheme(value), // Đổi theme mode toàn app 
              ),
            ],
          )
        ],
      ),
      body: const Center(
        child: Text(
          'This is a simple screen with theme toggle.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton( // Có cấu trúc FAB theo yêu cầu đề bài [cite: 49]
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}