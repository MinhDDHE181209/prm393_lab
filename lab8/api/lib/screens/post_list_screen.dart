import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _postsFuture; // Biến lưu trữ luồng dữ liệu Future

  @override
  void initState() {
    super.initState() ;
    _refreshData(); // Kích hoạt gọi API ngay khi màn hình vừa mở
  }

  // Hàm làm mới dữ liệu để hỗ trợ tính năng Pull-to-Refresh hoặc bấm nút tải lại
  void _refreshData() {
    setState(() {
      _postsFuture = _apiService.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('API Powered Posts', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData, // Nút làm mới thủ công trên thanh AppBar
          )
        ],
      ),
      // Lab 8.2 & 8.4: Dùng FutureBuilder lắng nghe sự thay đổi trạng thái của API bất đồng bộ
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          // TRẠNG THÁI 1: Hệ thống đang tải dữ liệu (Waiting / Loading)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.teal), // Vòng xoay Loading
                  SizedBox(height: 16),
                  Text('Fetching data from API, please wait...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // TRẠNG THÁI 2: Xảy ra lỗi trong quá trình xử lý (HasError)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off_rounded, size: 70, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    const Text(
                      'Oops! Something went wrong',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}', // Hiển thị chi tiết mã lỗi thân thiện với lập trình viên
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _refreshData, // Nút "Retry" hỗ trợ tải lại khi mất kết nối mạng
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }

          // TRẠNG THÁI 3: Tải dữ liệu thành công hoàn toàn (HasData)
          if (snapshot.hasData) {
            final posts = snapshot.data!;
            
            // Tính năng nâng cao: Thêm tính năng kéo để làm mới (RefreshIndicator) tăng điểm UX
            return RefreshIndicator(
              onRefresh: () async => _refreshData(),
              color: Colors.teal,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        foregroundColor: Colors.teal,
                        child: Text('#${post.id}'), // Hiển thị ID của bài viết bài post
                      ),
                      title: Text(
                        post.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Cắt ngắn chữ nếu tiêu đề quá dài
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // Hiển thị mô tả tóm gọn trong 2 dòng
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                      onTap: () {
                        // Sinh viên có thể nâng cấp mở màn hình chi tiết tại đây nếu muốn
                      },
                    ),
                  );
                },
              ),
            );
          }

          // Trường hợp dự phòng nếu không thuộc trạng thái nào
          return const Center(child: Text('No data found.'));
        },
      ),
    );
  }
}