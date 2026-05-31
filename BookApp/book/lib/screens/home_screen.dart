import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/firestore_book_service.dart';
import '../widgets/book_card.dart';
import 'table_of_contents_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookService = FirestoreBookService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện sách'),
        centerTitle: true,
      ),
      body: StreamBuilder<BooksSnapshot>(
        stream: bookService.watchBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Lỗi tải sách: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final books = data.books;

          if (books.isEmpty) {
            return const Center(
              child: Text('Chưa có sách trên Firestore.'),
            );
          }

          return Column(
            children: [
              if (data.isFromCache)
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.offline_pin,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Đang đọc từ cache — hỗ trợ offline',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: books.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookCard(
                      book: book,
                      onTap: () => _openBook(context, book),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openBook(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TableOfContentsScreen(book: book),
      ),
    );
  }
}
