import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> movies = [
      {'title': 'Avatar', 'initial': 'A'},
      {'title': 'Inception', 'initial': 'I'},
      {'title': 'Interstellar', 'initial': 'I'},
      {'title': 'Joker', 'initial': 'J'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 – Layout De...')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Now Playing',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( // Tránh lỗi overflow tràn màn hình bằng cách bọc ListView trong Expanded
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), // Spacing đồng đều [cite: 41]
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Text(movies[index]['initial']!),
                      ),
                      title: Text(movies[index]['title']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: const Text('Sample description'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}