import 'package:flutter/material.dart';
// import 'services/notification_service.dart';
import 'screens/splash_screen.dart'; // Import màn hình chờ vào đây

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService.init(); // Bật loa thông báo
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const SplashScreen(), // Chỉ gọi duy nhất màn đầu tiên
    );
  }
}