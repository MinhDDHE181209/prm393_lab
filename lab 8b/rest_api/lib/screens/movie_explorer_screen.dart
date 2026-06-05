import 'package:flutter/material.dart';
import '../models/tmdb_movie.dart';
import '../services/movie_api_service.dart';

class MovieExplorerScreen extends StatefulWidget {
  const MovieExplorerScreen({super.key});

  @override
  State<MovieExplorerScreen> createState() => _MovieExplorerScreenState();
}

class _MovieExplorerScreenState extends State<MovieExplorerScreen> {
  final MovieApiService _apiService = MovieApiService();
  late Future<List<TmdbMovie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() {
    setState(() {
      _moviesFuture = _apiService.fetchTrendingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Màu nền tối chuẩn rạp phim Cine UX
      appBar: AppBar(
        title: const Text('🍿 Movie Explorer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1F1F1F),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.cached_rounded),
            onPressed: _loadMovies, // Nút làm mới dữ liệu
          )
        ],
      ),
      body: FutureBuilder<List<TmdbMovie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          // 1. TRẠNG THÁI ĐANG TẢI (Loading State)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.amber),
                  SizedBox(height: 16),
                  Text('Searching for blockbusters...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // 2. TRẠNG THÁI LỖI MẠNG (Error & Retry State)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.amber),
                    const SizedBox(height: 16),
                    const Text('Connection Failed', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      onPressed: _loadMovies,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. TRẠNG THÁI THÀNH CÔNG (Success Data Display)
          if (snapshot.hasData) {
            final allMovies = snapshot.data!;

            // LAB 8B CORE ELEMENT: Lọc ra các siêu phẩm có điểm vote >= 8.0 làm "Top Choice" giúp người dùng ra quyết định xem phim
            final topChoices = allMovies.where((m) => m.voteAverage >= 8.0).toList();

            return RefreshIndicator(
              onRefresh: () async => _loadMovies(),
              color: Colors.amber,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- PHẦN GỢI Ý ĐẶC BIỆT (Purpose-driven Element) ---
                    const Text(
                      '🔥 Highly Recommended (Rating ≥ 8.0)',
                      style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 160,
                      child: topChoices.isEmpty
                          ? const Center(child: Text('No top movies today', style: TextStyle(color: Colors.grey)))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal, // Cuộn ngang độc đáo
                              itemCount: topChoices.length,
                              itemBuilder: (context, index) {
                                final movie = topChoices[index];
                                return Container(
                                  width: 130,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1F1F1F),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                          child: Image.network(
                                            movie.posterPath,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (c, e, s) => const Icon(Icons.movie, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          movie.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 24),

                    // --- DANH SÁCH TẤT CẢ CÁC PHIM XU HƯỚNG ---
                    const Text(
                      '🌟 Trending Today',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Để lồng mượt trong SingleChildScrollView
                      itemCount: allMovies.length,
                      itemBuilder: (context, index) {
                        final movie = allMovies[index];
                        return Card(
                          color: const Color(0xFF1F1F1F),
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    movie.posterPath,
                                    width: 80,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => Container(color: Colors.grey, width: 80, height: 110),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Release: ${movie.releaseDate}',
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                      const SizedBox(height: 8),
                                      // Thanh Badge hiển thị điểm đánh giá nổi bật
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: movie.voteAverage >= 8.0 ? Colors.amber : Colors.grey[800],
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          '⭐ ${movie.voteAverage.toStringAsFixed(1)}',
                                          style: TextStyle(
                                            color: movie.voteAverage >= 8.0 ? Colors.black : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('No movies available.', style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }
}