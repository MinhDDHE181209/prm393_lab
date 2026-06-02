import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

// ==========================================
// STEP 2: DEFINE DATA MODEL & SAMPLE DATA
// ==========================================

// Định nghĩa lớp đối tượng Movie để quản lý dữ liệu phim [cite: 218]
class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;
  bool isFavorite; // Biến trạng thái để xử lý chức năng nâng cao (Favorite toggle) [cite: 213]

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
    this.isFavorite = false,
  });
}

// Tạo danh sách dữ liệu mẫu (Static Sample Data) giống hệt trong ảnh đề bài [cite: 210, 218]
final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Dune: Part Two',
    posterUrl: 'https://picsum.photos/id/10/600/400', // Dùng link ảnh ngẫu nhiên có sẵn từ Picsum
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: ['Official Trailer #1', 'IMAX Sneak Peek'],
  ),
  Movie(
    id: '2',
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://picsum.photos/id/15/600/400',
    overview: 'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: ['Red Band Trailer', 'Behind the Scenes'],
  ),
];

// ==========================================
// MAIN APPLICATION SCADDOLDING
// ==========================================

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Detail App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Màu nền sáng nhẹ như trong ảnh mẫu
      ),
      home: const HomeScreen(), // Màn hình đầu tiên là Home Screen [cite: 197]
    );
  }
}

// ==========================================
// STEP 3: BUILD HOME SCREEN
// ==========================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
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
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              // Khi chạm vào Card sẽ điều hướng sang màn hình Chi tiết sử dụng Navigator.push [cite: 206, 219]
              onTap: () async {
                // Đợi kết quả trả về từ màn hình Chi tiết để cập nhật lại trạng thái nút Favorite [cite: 227]
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie), // Truyền đối tượng Movie qua Screen mới [cite: 208]
                  ),
                );
                setState(() {}); // Làm mới danh sách nếu có thay đổi trạng thái từ màn hình bên trong
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Hiển thị ảnh Poster Phim nhỏ bên trái [cite: 197]
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        movie.posterUrl,
                        width: 100,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Hiển thị tiêu đề và thông tin text ở giữa [cite: 197]
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '⭐ ${movie.rating} • ${movie.genres.join(", ")}',
                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    // Biểu tượng icon mũi tên chỉ hướng đi tiếp ở góc phải [cite: 197]
                    Icon(Icons.chevron_right, color: Colors.grey[600]),
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

// ==========================================
// STEP 4: BUILD MOVIE DETAIL SCREEN
// ==========================================

class MovieDetailScreen extends StatefulWidget {
  final Movie movie; // Nhận đối tượng Movie được truyền từ HomeScreen sang [cite: 208]

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
        title: Text(movie.title), // Tiêu đề AppBar là tên phim [cite: 198]
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Nút quay lại màn hình cũ [cite: 232]
        ),
      ),
      // Dùng SingleChildScrollView để giao diện có thể cuộn mượt mà trên nhiều kích thước màn hình [cite: 209]
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Banner sử dụng Stack kết hợp Image và Hiệu ứng Gradient mờ [cite: 199, 222]
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: 230,
                  fit: BoxFit.cover,
                ),
                // Lớp phủ Gradient đen mờ từ dưới lên để nổi bật chữ [cite: 199]
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
                // Chữ Tiêu đề phim hiển thị đè lên trên Banner [cite: 222]
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

            // 2. Danh sách các Genres (Thể loại) hiển thị dưới dạng Chips bao bọc bởi Wrap [cite: 200, 223]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0,
                children: movie.genres.map((genre) {
                  return Chip(
                    label: Text(genre, style: TextStyle(color: Colors.grey[800])),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // 3. Đoạn văn mô tả tóm tắt nội dung phim (Overview Text) [cite: 201, 224]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Hàng nút chức năng hành động: Favorite, Rate, Share [cite: 202, 225]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Nút Favorite có chức năng cập nhật và giữ trạng thái bằng setState 
                  _buildActionButton(
                    icon: movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: movie.isFavorite ? Colors.red : Colors.grey[700]!,
                    label: 'Favorite',
                    onTap: () {
                      setState(() {
                        movie.isFavorite = !movie.isFavorite;
                      });
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.star_border,
                    color: Colors.grey[700]!,
                    label: 'Rate',
                    onTap: () {
                      // Xử lý sự kiện Rate
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.share,
                    color: Colors.grey[700]!,
                    label: 'Share',
                    onTap: () {
                      // Xử lý sự kiện Share
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Danh sách các Trailer của bộ phim [cite: 203, 226]
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Trailers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Thay vì dùng ListView.builder trực tiếp dễ gây lỗi tràn do Column bao bọc, 
            // ta sử dụng cấu trúc map/hoặc dùng ListView.builder kết hợp thuộc tính shrinkWrap [cite: 226]
            ListView.builder(
              shrinkWrap: true, // Cho phép ListView co dãn vừa kích thước nội dung [cite: 209]
              physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa tính năng cuộn riêng để đi theo cuộn tổng của màn hình
              itemCount: movie.trailers.length,
              itemBuilder: (context, tIndex) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.play_circle_fill, size: 32, color: Color(0xFF495057)),
                      title: Text(
                        movie.trailers[tIndex],
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        // Hành động khi nhấn mở Trailer
                      },
                    ),
                    if (tIndex < movie.trailers.length - 1)
                      const Divider(indent: 16, endIndent: 16), // Tạo đường gạch phân cách giữa các trailer như hình mẫu
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Hàm helper tự thiết kế để tái sử dụng giao diện cho các nút hành động [cite: 240]
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
            Text(
              label,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}