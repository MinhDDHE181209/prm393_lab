import 'package:flutter/material.dart';
// Import màn hình chính đã được refactor từ thư mục screens
import 'screens/financial_plan_screen.dart'; 

void main() {
  // Đảm bảo hệ thống binding của Flutter được khởi tạo đầy đủ trước khi chạy app
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial Plan Dashboard',
      
      // Định hình cấu hình Dark Theme (Tông tối xanh đậm) chuẩn theo bản thiết kế
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff0d1b1e), // Nền tối gốc
        
        // Cấu hình đồng bộ màu nền cho các thanh điều hướng đáy và các component phụ
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: const Color(0xff112529),
          selectedItemColor: const Color(0xff2ec4b6),
          unselectedItemColor: Colors.grey,
        ),
      ),
      
      // Đặt màn hình Lập kế hoạch tài chính làm màn hình chạy đầu tiên
      home: const FinancialPlanScreen(), 
    );
  }
}