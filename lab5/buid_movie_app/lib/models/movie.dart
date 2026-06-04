// Định nghĩa lớp đối tượng Movie để truyền nhận dữ liệu giữa 2 màn hình
class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;
  bool isFavorite; // Biến trạng thái xử lý chức năng nâng cao (Favorite toggle)

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
    this.isFavorite = false, // Mặc định ban đầu phim chưa được yêu thích
  });
}