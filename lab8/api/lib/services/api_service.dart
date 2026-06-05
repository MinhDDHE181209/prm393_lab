import 'dart:convert';
import 'package:http/http.dart' as http; 
import '../models/post.dart';

class ApiService {
  // Định nghĩa endpoint công khai theo đề bài
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Lab 8.1 & 8.2: Hàm GET dữ liệu bất đồng bộ trả về danh sách List<Post>
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl)).timeout(
        const Duration(seconds: 10), // Đặt giới hạn timeout đề phòng mạng lag
      );

      // Nếu mã trạng thái trả về 200 (Thành công)
      if (response.statusCode == 200) {
        // Decode chuỗi JSON thô sang cấu trúc List của Dart
        final List<dynamic> jsonList = json.decode(response.body);
        
        // Duyệt mảng chạy qua hàm factory .fromJson để ép kiểu thành List<Post>
        return jsonList.map((jsonItem) => Post.fromJson(jsonItem)).toList();
      } else {
        // Trường hợp API trả về lỗi hệ thống (ví dụ: 404, 500)
        throw Exception('Failed to load posts (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      // Bắt các lỗi ngoại lệ kết nối Internet, không có mạng hoặc timeout
      throw Exception('Network error or server unreachable: $e');
    }
  }
}