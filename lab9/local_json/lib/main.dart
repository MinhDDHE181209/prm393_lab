import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'movie_model.dart';

void main() {
  runApp(const LocalStorageApp());
}

class LocalStorageApp extends StatelessWidget {
  const LocalStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 9 - Local Movie DB',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber, 
          brightness: Brightness.dark // Giao diện tối cho đồng bộ rạp phim chuyên nghiệp
        ),
      ),
      home: const MovieDatabaseScreen(),
    );
  }
}

class MovieDatabaseScreen extends StatefulWidget {
  const MovieDatabaseScreen({super.key});

  @override
  State<MovieDatabaseScreen> createState() => _MovieDatabaseScreenState();
}

class _MovieDatabaseScreenState extends State<MovieDatabaseScreen> {
  List<LocalMovie> _allMovies = []; // Danh sách bộ nhớ RAM gốc trong máy
  List<LocalMovie> _filteredMovies = []; // Danh sách hiển thị sau khi lọc tìm kiếm
  bool _isLoading = true;

  // Quản lý các ô nhập dữ liệu của Form
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initMovieDatabase();
    _searchController.addListener(_runLiveSearch); // Lắng nghe thanh tìm kiếm thay đổi
  }

  // LAB 9.2: Hàm tìm file lưu trữ ẩn trong thư mục Document của điện thoại
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/stored_movies_db.json');
  }

  // TỔNG HỢP LAB 9.1 & 9.2: Khởi tạo dữ liệu lúc chạy app
  Future<void> _initMovieDatabase() async {
    try {
      final file = await _getLocalFile();
      String jsonContent;

      if (await file.exists()) {
        // Tình huống: Người dùng đã thêm/sửa/xóa từ trước -> Đọc file từ bộ nhớ máy (Lab 9.2)
        jsonContent = await file.readAsString();
      } else {
        // Tình huống: Lần đầu tiên bật ứng dụng -> Đọc file mặc định từ thư mục Assets (Lab 9.1)
        jsonContent = await rootBundle.loadString('lib/assets/movies.json');
        await file.writeAsString(jsonContent); // Nhân bản ghi ra file cục bộ để xử lý CRUD lâu dài
      }

      final List<dynamic> decodedList = json.decode(jsonContent);
      setState(() {
        _allMovies = decodedList.map((item) => LocalMovie.fromJson(item)).toList();
        _filteredMovies = _allMovies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi tải dữ liệu: $e')));
    }
  }

  // LAB 9.3 AUTO-SAVE: Hàm đồng bộ ghi dữ liệu xuống ổ đĩa cứng mỗi khi có thay đổi CRUD
  Future<void> _syncDataToStorage() async {
    try {
      final file = await _getLocalFile();
      List<Map<String, dynamic>> rawList = _allMovies.map((m) => m.toJson()).toList();
      String updatedJsonString = json.encode(rawList);
      await file.writeAsString(updatedJsonString); // Lưu đè danh sách mới nhất
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể đồng bộ ổ đĩa: $e')));
    }
  }

  // LAB 9.3 SEARCH BAR: Lọc phim theo tiêu đề hoặc tên đạo diễn thời gian thực
  void _runLiveSearch() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMovies = _allMovies;
      } else {
        _filteredMovies = _allMovies.where((movie) {
          return movie.title.toLowerCase().contains(query) || 
                 movie.director.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // LAB 9.3 FORM DIALOG: Hộp thoại đa năng xử lý tác vụ THÊM MỚI (Create) hoặc SỬA (Update)
  void _openFormDialog(LocalMovie? existingMovie) {
    // Nếu truyền vào đối tượng cũ -> Điền dữ liệu cũ lên form để SỬA
    if (existingMovie != null) {
      _titleController.text = existingMovie.title;
      _directorController.text = existingMovie.director;
      _yearController.text = existingMovie.year;
    } else {
      // Nếu là null -> Xóa trắng form để chuẩn bị THÊM MỚI
      _titleController.clear();
      _directorController.clear();
      _yearController.clear();
    }

    showDialog(
      context: context,
      barrierDismissible: false, // Bắt buộc tương tác không được bấm ra ngoài
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(existingMovie == null ? Icons.add_box_rounded : Icons.edit_document, color: Colors.amber),
            const SizedBox(width: 8),
            Text(existingMovie == null ? 'Thêm Phim Mới' : 'Cập Nhật Thông Tin'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Tên bộ phim *', prefixIcon: Icon(Icons.movie_rounded))),
              const SizedBox(height: 8),
              TextField(controller: _directorController, decoration: const InputDecoration(labelText: 'Đạo diễn *', prefixIcon: Icon(Icons.person_rounded))),
              const SizedBox(height: 8),
              TextField(
                controller: _yearController, 
                decoration: const InputDecoration(labelText: 'Năm sản xuất', prefixIcon: Icon(Icons.calendar_month_rounded)),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy bỏ', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            onPressed: () {
              if (_titleController.text.trim().isEmpty || _directorController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập đầy đủ Tên phim và Đạo diễn!')));
                return;
              }

              setState(() {
                if (existingMovie == null) {
                  // Hành động: THÊM PHIM MỚI vào mảng
                  final newMovie = LocalMovie(
                    id: DateTime.now().millisecondsSinceEpoch.toString(), // Tạo mã ID duy nhất bằng dấu thời gian
                    title: _titleController.text.trim(),
                    director: _directorController.text.trim(),
                    year: _yearController.text.trim().isEmpty ? '2026' : _yearController.text.trim(),
                  );
                  _allMovies.add(newMovie);
                } else {
                  // Hành động: SỬA THÔNG TIN đối tượng đã tồn tại
                  existingMovie.title = _titleController.text.trim();
                  existingMovie.director = _directorController.text.trim();
                  existingMovie.year = _yearController.text.trim();
                }
                
                _runLiveSearch(); // Đổ lại danh sách bộ lọc giao diện
                _syncDataToStorage(); // Gọi hàm tự động lưu đè xuống ổ đĩa cứng (Lab 9.2 Persistence)
              });
              Navigator.pop(context);
            },
            child: Text(existingMovie == null ? 'Thêm Ngay' : 'Cập Nhật'),
          ),
        ],
      ),
    );
  }

  // LAB 9.3 DELETE: Hộp thoại xác nhận xóa phim an toàn
  void _confirmDeleteMovie(LocalMovie movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('Xác Nhận Xóa'),
          ],
        ),
        content: Text('Bạn có chắc chắn muốn gỡ bộ phim "${movie.title}" ra khỏi cơ sở dữ liệu không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            onPressed: () {
              setState(() {
                _allMovies.removeWhere((element) => element.id == movie.id); // Xóa khỏi bộ nhớ
                _runLiveSearch(); // Cập nhật màn hình UI
                _syncDataToStorage(); // Lưu lại file JSON mới đã xóa sạch phần tử
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa bộ phim thành công!')));
            },
            child: const Text('Xóa Bỏ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Local JSON Media Database', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.amber))
          : Column(
              children: [
                // --- PHẦN TÌM KIẾM THEO TÊN HOẶC ĐẠO DIỄN (Lab 9.3) ---
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm tên phim hoặc đạo diễn...',
                      prefixIcon: const Icon(Icons.search_rounded, color: Colors.amber),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(icon: const Icon(Icons.clear), onPressed: () => _searchController.clear())
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.amber, width: 2),
                      ),
                    ),
                  ),
                ),

                // --- DANH SÁCH LISTVIEW HIỂN THỊ THÀNH PHẦN (Lab 9.1 & 9.3) ---
                Expanded(
                  child: _filteredMovies.isEmpty
                      ? const Center(
                          child: Text('Không tìm thấy dữ liệu trùng khớp!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: _filteredMovies.length,
                          itemBuilder: (context, index) {
                            final movie = _filteredMovies[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  foregroundColor: Colors.black,
                                  child: Icon(Icons.video_library_rounded),
                                ),
                                title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text('Đạo diễn: ${movie.director}\nNăm sản xuất: ${movie.year}', style: const TextStyle(color: Colors.grey, height: 1.3)),
                                ),
                                isThreeLine: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Nút Sửa (Update)
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined, color: Colors.blueAccent),
                                      onPressed: () => _openFormDialog(movie),
                                    ),
                                    // Nút Xóa (Delete)
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                      onPressed: () => _confirmDeleteMovie(movie),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      // Nút góc phải bên dưới mở form thêm phim mới (Create)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openFormDialog(null),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_circle_outline_rounded),
        label: const Text('Thêm Phim Mới', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _titleController.dispose();
    _directorController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}