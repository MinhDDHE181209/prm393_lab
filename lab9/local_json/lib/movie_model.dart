class LocalMovie {
  String id;
  String title;
  String director;
  String year;

  LocalMovie({
    required this.id,
    required this.title,
    required this.director,
    required this.year,
  });

  // Chuyển từ Bản đồ JSON sang Đối tượng mã Dart (Dùng khi đọc file)
  factory LocalMovie.fromJson(Map<String, dynamic> json) {
    return LocalMovie(
      id: json['id'].toString(),
      title: json['title'] as String? ?? 'Chưa có tên',
      director: json['director'] as String? ?? 'Không rõ đạo diễn',
      year: json['year'].toString(),
    );
  }

  // Chuyển ngược từ Đối tượng Dart sang cấu trúc JSON Map (Dùng khi ghi/lưu file)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'year': year,
    };
  }
}