import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import 'detail_screen.dart'; // Import để có thể chuyển sang DetailScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Màu nền sáng nhẹ thanh lịch
      appBar: AppBar(
        title: const Text(
          'Movies App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleMovies.length,
        itemBuilder: (context, index) {
          final movie = sampleMovies[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell( // Dùng InkWell tạo hiệu ứng gợn sóng khi tap
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                // Điều hướng sang màn hình Chi tiết và đợi kết quả trả về bằng await
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie), // Truyền đối tượng Movie đi
                  ),
                );
                // Sau khi từ màn hình Chi tiết bấm Back về, làm mới lại trạng thái (để cập nhật icon Favorite nếu có đổi)
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Hiển thị Poster Phim nhỏ bên góc trái màn hình
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        movie.posterUrl,
                        width: 100,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Hiển thị nội dung Text thông tin phim ở giữa
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '⭐ ${movie.rating}  •  ${movie.genres.first}', // Hiển thị điểm và thể loại chính
                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    // Icon mũi tên chỉ hướng đi tiếp ở góc phải
                    Icon(Icons.chevron_right, color: Colors.grey[400]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}