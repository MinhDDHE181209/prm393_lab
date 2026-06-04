import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie; // Nhận đối tượng Movie truyền từ HomeScreen sang

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title), // Tiêu đề AppBar là tên phim
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Quay lại màn hình trước đó bằng nút Back
        ),
      ),
      // Sử dụng SingleChildScrollView giúp màn hình cuộn mượt mà không bị lỗi overflow
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Banner sử dụng Stack + Image.network + Lớp phủ mờ Gradient
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                // Tạo lớp mặt nạ Gradient mờ đen từ dưới lên để nổi bật chữ
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ),
                // Tiêu đề phim lớn nằm đè lên góc dưới của banner banner
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 2. Danh sách các Genres hiển thị dưới dạng Chips bọc bởi Wrap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0, // Khoảng cách ngang giữa các Chip
                runSpacing: 4.0, // Khoảng cách dọc khi xuống hàng
                children: movie.genres.map((genre) {
                  return Chip(
                    label: Text(genre, style: TextStyle(color: Colors.grey[800])),
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Đoạn văn mô tả tóm tắt nội dung phim (Overview text với Padding)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 16, height: 1.4, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Hàng nút chức năng hành động: Favorite, Rate, Share
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Nút Favorite có chức năng thay đổi trạng thái động qua setState()
                  _buildActionButton(
                    icon: movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: movie.isFavorite ? Colors.red : Colors.grey[700]!,
                    label: 'Favorite',
                    onTap: () {
                      setState(() {
                        movie.isFavorite = !movie.isFavorite; // Toggle trạng thái
                      });
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.star_border,
                    color: Colors.grey[700]!,
                    label: 'Rate',
                    onTap: () {
                      // Hành động Rate phim
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.share,
                    color: Colors.grey[700]!,
                    label: 'Share',
                    onTap: () {
                      // Hành động Share phim
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Danh sách các Trailer của bộ phim sử dụng ListView.builder
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Trailers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Sử dụng shrinkWrap và NeverScrollableScrollPhysics để ListView lồng được bên trong SingleChildScrollView mà không bị crash
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: movie.trailers.length,
              itemBuilder: (context, tIndex) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.play_circle_fill, size: 32, color: Colors.deepPurple),
                      title: Text(
                        movie.trailers[tIndex],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        // Hành động khi nhấn play trailer
                      },
                    ),
                    if (tIndex < movie.trailers.length - 1)
                      const Divider(indent: 16, endIndent: 16), // Đường kẻ phân cách giữa các item trailer
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Hàm phụ (Helper method) tự thiết kế để tái sử dụng giao diện cho các nút chức năng
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
          ],
        ),
      ),
    );
  }
}