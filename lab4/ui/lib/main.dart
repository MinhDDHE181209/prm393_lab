import 'package:flutter/material.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'theme_demo.dart';
import 'ui_fixes_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Biến quản lý trạng thái Dark Mode cho Exercise 4
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Flutter UI',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: _themeMode,
      home: MainMenu(toggleTheme: toggleTheme, currentThemeMode: _themeMode),
    );
  }
}

class MainMenu extends StatelessWidget {
  final Function(bool) toggleTheme;
  final ThemeMode currentThemeMode;

  const MainMenu({super.key, required this.toggleTheme, required this.currentThemeMode});

  @override
  Widget build(BuildContext context) {
    // Danh sách các Exercise để hiển thị lên Menu
    final exercises = [
      {'title': 'Exercise 1 – Core Widgets Demo', 'screen': const CoreWidgetsDemo()},
      {'title': 'Exercise 2 – Input Controls Demo', 'screen': const InputControlsDemo()},
      {'title': 'Exercise 3 – Layout Demo', 'screen': const LayoutDemo()},
      {
        'title': 'Exercise 4 – App Structure & Theme', 
        'screen': ThemeDemo(toggleTheme: toggleTheme, currentThemeMode: currentThemeMode)
      },
      {'title': 'Exercise 5 – Common UI Fixes', 'screen': const UIFixesDemo()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 – Flutter UI Fundament...')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(exercises[index]['title'] as String, style: const TextStyle(fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => exercises[index]['screen'] as Widget),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}