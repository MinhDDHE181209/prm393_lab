class TmdbMovie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;

  TmdbMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  // Hàm Factory chuyển đổi dữ liệu từ Map JSON của TMDB sang Object Dart
  factory TmdbMovie.fromJson(Map<String, dynamic> json) {
    return TmdbMovie(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Unknown Title',
      overview: json['overview'] as String? ?? 'No overview available.',
      // Dùng link ảnh mặc định nếu API không trả về đường dẫn ảnh
      posterPath: json['poster_path'] as String? ?? 'https://picsum.photos/id/20/400/600',
      voteAverage: (json['vote_average'] as num? ?? 0.0).toDouble(),
      releaseDate: json['release_date'] as String? ?? 'N/A',
    );
  }
}