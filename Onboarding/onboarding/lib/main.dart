import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Thay đổi import sang Login Screen

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Flow',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff121212),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xff121212),
          elevation: 0,
        ),
      ),
      // App sẽ chạy màn hình Login này lên trước tiên!
      home: const LoginScreen(), 
    );
  }
}