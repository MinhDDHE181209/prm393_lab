import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tmdb_movie.dart';

class MovieApiService {
  static const String _apiUrl = 'https://mocki.io/v1/d7576960-51c4-4072-aa22-72e117c8be82';

  Future<List<TmdbMovie>> fetchTrendingMovies() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        // SỬA ĐOẠN NÀY: Ép kiểu giải mã UTF-8 để tránh lỗi ký tự đặc biệt gây crash mạng
        final String decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> decodedData = json.decode(decodedBody);
        
        final List<dynamic> results = decodedData['results'] ?? [];
        return results.map((jsonItem) => TmdbMovie.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Server trả về lỗi: ${response.statusCode}');
      }
    } catch (e) {
      // Nếu giả lập lỗi mạng, nó sẽ in rõ lý do ở đây để bạn debug
      throw Exception('Lỗi kết nối mạng: $e');
    }
  }
}