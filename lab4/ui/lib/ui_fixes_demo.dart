import 'package:flutter/material.dart';

class UIFixesDemo extends StatelessWidget {
  const UIFixesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 – Common U...')),
      // Dùng SingleChildScrollView bọc ngoài cùng để ngăn chặn lỗi overflow trên màn hình nhỏ 
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Correct ListView inside Column using Expanded',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // ĐÃ FIX: ListView.builder đặt trong Column bắt buộc phải bọc bằng cặp SizedBox có chiều cao xác định hoặc widget Expanded/Flexible 
              SizedBox(
                height: 300, 
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(), // Tắt scroll của ListView để cuộn mượt theo SingleChildScrollView
                  children: const [
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie A')),
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie B')),
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie C')),
                    ListTile(leading: Icon(Icons.movie), title: Text('Movie D')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}