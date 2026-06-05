import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/movie.dart';

class MovieBrowsingScreen extends StatefulWidget {
  const MovieBrowsingScreen({super.key});

  @override
  State<MovieBrowsingScreen> createState() => _MovieBrowsingScreenState();
}

class _MovieBrowsingScreenState extends State<MovieBrowsingScreen> {
  // Các trạng thái quản lý bộ lọc
  String _searchQuery = '';
  final Set<String> _selectedGenres = {}; // Dùng Set để quản lý các thể loại được chọn
  String _selectedSort = 'A–Z'; // Giá trị sắp xếp mặc định

  // Danh sách các thể loại phim hiển thị trên các Chip[cite: 3]
  final List<String> _availableGenres = ['Action', 'Sci-Fi', 'Comedy', 'Drama', 'Adventure'];

  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------
    // STEP 7: FILTER AND SORT THE MOVIE LIST[cite: 3]
    // -----------------------------------------------------------------
    List<Movie> visibleMovies = allMovies.where((movie) {
      // 1. Lọc theo từ khóa tìm kiếm (không phân biệt chữ hoa thường)[cite: 3]
      final matchesSearch = movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
      
      // 2. Lọc theo thể loại: Nếu có chip được chọn, phim phải chứa ít nhất một thể loại trong đó[cite: 3]
      final matchesGenre = _selectedGenres.isEmpty || 
          movie.genres.any((g) => _selectedGenres.contains(g));
          
      return matchesSearch && matchesGenre;
    }).toList();

    // 3. Áp dụng sắp xếp danh sách phim theo lựa chọn từ Dropdown[cite: 3]
    if (_selectedSort == 'A–Z') {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    } else if (_selectedSort == 'Z–A') {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    } else if (_selectedSort == 'Year') {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year)); // Năm giảm dần
    } else if (_selectedSort == 'Rating') {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating)); // Điểm số giảm dần
    }

    // Sử dụng MediaQuery để xác định kích thước màn hình nhằm áp dụng breakpoint 800px[cite: 3]
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth >= 800; // Breakpoint phân biệt Phone và Tablet/Web[cite: 3]

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea( // Dùng SafeArea để né các phần tai thỏ, camera đục lỗ[cite: 3]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // LAB 6.1: RESPONSIVE HERO & HEADING SECTION[cite: 3]
            // =========================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find a Movie', // Tiêu đề bắt buộc[cite: 3]
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Mode: ${isWideScreen ? "Tablet / Web Layout" : "Mobile Layout"}',
                    style: TextStyle(color: Colors.deepPurple.shade100, fontSize: 14),
                  ),
                ],
              ),
            ),

            // =========================================================
            // LAB 6.2: SEARCH, GENRE CHIPS & SORT BAR[cite: 3]
            // =========================================================
            
            // 1. Ô tìm kiếm (Search Bar)[cite: 3]
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Cập nhật từ khóa tìm kiếm[cite: 3]
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search movie by title...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),

            // 2. Khu vực hiển thị các Thể loại phim dưới dạng Wrap (Genre Chips)[cite: 3]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  const Text(
                    'Genres: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  // Thêm Badge hiển thị số lượng thể loại đang chọn (Bonus)[cite: 3]
                  if (_selectedGenres.isNotEmpty)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        '${_selectedGenres.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  const Spacer(),
                  if (_selectedGenres.isNotEmpty)
                    TextButton(
                      onPressed: () => setState(() => _selectedGenres.clear()), // Nút xóa nhanh bộ lọc (Bonus)[cite: 3]
                      child: const Text('Clear filters', style: TextStyle(fontSize: 13)),
                    )
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap( // Sử dụng Wrap để các chip tự động xuống hàng khi thiếu không gian màn hình[cite: 3]
                spacing: 8.0,
                runSpacing: 4.0,
                children: _availableGenres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    selectedColor: Colors.deepPurple.shade100,
                    checkmarkColor: Colors.deepPurple,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedGenres.add(genre); // Thêm vào danh sách lọc[cite: 3]
                        } else {
                          _selectedGenres.remove(genre); // Xóa khỏi danh sách lọc[cite: 3]
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            // 3. Hàng chứa Dropdown sắp xếp thứ tự phim (Sort Bar)[cite: 3]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Results: ${visibleMovies.length} movies',
                    style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      const Text('Sort: ', style: TextStyle(fontWeight: FontWeight.w500)),
                      DropdownButton<String>(
                        value: _selectedSort,
                        underline: const SizedBox(),
                        items: ['A–Z', 'Z–A', 'Year', 'Rating'].map((String val) { // Đầy đủ tùy chọn đề bài yêu cầu[cite: 3]
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSort = newValue; // Cập nhật trạng thái sắp xếp[cite: 3]
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // =========================================================
            // LAB 6.3: RESPONSIVE MOVIE LIST & TABLET LAYOUT[cite: 3]
            // =========================================================
            Expanded(
              child: visibleMovies.isEmpty
                  ? const Center(child: Text('No movies match your filters.'))
                  : LayoutBuilder( // Sử dụng LayoutBuilder để quyết định kiểu bố cục dựa trên không gian khả dụng[cite: 3]
                      builder: (context, constraints) {
                        if (constraints.maxWidth >= 800) {
                          // Nếu chiều rộng >= 800px: Hiển thị dạng lưới GridView với 2 cột[cite: 3]
                          return GridView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: visibleMovies.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 cột cho màn hình lớn[cite: 3]
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.3, // Định hình tỷ lệ cân đối cho Card nằm ngang
                            ),
                            itemBuilder: (context, index) {
                              return _buildMovieCard(visibleMovies[index], isTablet: true);
                            },
                          );
                        } else {
                          // Ngược lại, hiển thị dạng danh sách ListView xếp dọc đơn thuần 1 cột cho màn hình nhỏ[cite: 3]
                          return ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: visibleMovies.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: _buildMovieCard(visibleMovies[index], isTablet: false),
                              );
                            },
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Component Thẻ Phim dùng chung cho cả 2 chế độ hiển thị[cite: 3]
  Widget _buildMovieCard(Movie movie, {required bool isTablet}) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 110,
        child: Row(
          children: [
            // Thay đổi kích thước ảnh poster dựa vào màn hình Tablet vs Phone thông qua biến truyền vào (Bonus)[cite: 3]
            Image.network(
              movie.posterUrl,
              width: isTablet ? 100 : 85, // Màn hình rộng thì tăng size ảnh poster lớn hơn[cite: 3]
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title, // Tên phim[cite: 3]
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Year: ${movie.year} • ${movie.genres.join(", ")}', // Năm và danh sách thể loại[cite: 3]
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Hiển thị điểm rating bằng Text kèm Icon ngôi sao (Bonus)[cite: 3]
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.rating} / 10',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}