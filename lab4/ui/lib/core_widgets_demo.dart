import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Hành động khi nhấn nút Back (Quay lại)
            Navigator.maybePop(context);
          },
        ),
        backgroundColor: Colors.deepPurple.shade100, // Đổi màu nhẹ cho AppBar trông chuyên nghiệp
      ),
      body: SingleChildScrollView(
        // Dùng SingleChildScrollView để chống tràn hiển thị trên máy màn hình nhỏ
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái cho các Widget bên trong
          children: [
            // 1. Headline Text (Tiêu đề chữ lớn)
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16), // Tạo khoảng trống giữa các thành phần

            // 2. Icon using Material Icons (Biểu tượng)
            const Center(
              child: Icon(
                Icons.movie_filter_rounded, // Chọn icon liên quan đến chủ đề Phim ảnh giống Lab 5,6
                size: 80,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),

            // 3. Image.network (Hiển thị ảnh lấy từ internet)
            const Text(
              'Featured Poster:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // Bo tròn góc ảnh cho đẹp mắt
              child: Image.network(
                'https://png.pngtree.com/png-clipart/20221217/original/pngtree-boxers-in-fight-world-boxing-day-png-image_8761602.png', // Sử dụng link ảnh mạng bất kỳ hợp lệ
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover, // Cắt ảnh vừa vặn với tỷ lệ khung hình
                errorBuilder: (context, error, stackTrace) {
                  // Đề phòng thiết bị không có mạng hoặc link ảnh lỗi
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Text('Không thể tải ảnh từ Network')),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // 4. A Card containing a ListTile (Thẻ chứa danh sách)
            const Text(
              'Movie Information:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4, // Tạo độ bóng đổ sâu cho thẻ Card trông nổi bật hơn
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bo góc cho Card
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.star, // Icon ngôi sao nằm bên trái
                  size: 32,
                  color: Colors.amber,
                ),
                title: Text(
                  'Inception (2010)', // Tiêu đề chính của ListTile
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'A thief who steals corporate secrets through the use of dream-sharing technology.', // Tiêu đề phụ
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16), // Mũi tên nhỏ bên phải tăng độ thẩm mỹ
              ),
            ),
          ],
        ),
      ),
    );
  }
}