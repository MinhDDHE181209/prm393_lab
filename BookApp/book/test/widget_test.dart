import 'package:book/data/seed_books.dart';
import 'package:book/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BookCard hiển thị thông tin sách', (WidgetTester tester) async {
    final book = SeedBooks.all.first;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BookCard(book: book, onTap: () {}),
        ),
      ),
    );

    expect(find.text('Đắc Nhân Tâm'), findsOneWidget);
    expect(find.text('Dale Carnegie'), findsOneWidget);
  });
}
