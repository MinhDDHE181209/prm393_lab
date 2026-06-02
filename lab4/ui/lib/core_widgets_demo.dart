import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widge...'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Hành động khi bấm nút back (quay lại menu chính)
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Tạo khoảng cách padding xung quanh màn hình
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái cho các widget trong Column
          children: [
            // 1. Headline Text
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Tạo khoảng trống giữa các widget

            // 2. Icon bằng Material Icons
            const Center(
              child: Icon(
                Icons.movie, // Chọn icon liên quan đến phim ảnh giống như ảnh mẫu
                size: 80,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),

            // 3. Image.network (Sử dụng một URL ảnh mạng bất kỳ hợp lệ)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Bo góc ảnh cho đẹp
              child: Image.network(
                'https://png.pngtree.com/png-clipart/20221217/original/pngtree-boxers-in-fight-world-boxing-day-png-image_8761602.png', // Link ảnh mẫu từ Picsum
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover, // Cắt ảnh vừa vặn với khung
                errorBuilder: (context, error, stackTrace) {
                  // Đề phòng trường hợp mất mạng không load được ảnh
                  return const Center(child: Text('Không thể tải ảnh từ network'));
                },
              ),
            ),
            const SizedBox(height: 24),

            // 4. Card chứa ListTile bên trong
            Card(
              elevation: 2, // Tạo độ bóng nhẹ cho Card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bo góc Card
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.star, 
                  size: 32,
                  color: Colors.grey,
                ),
                title: Text(
                  'Movie Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('This is a sample ListTile inside a Card.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}