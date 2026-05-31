import 'package:cloud_firestore/cloud_firestore.dart';

import 'chapter.dart';

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.chapters,
  });

  final String id;
  final String title;
  final String author;
  final String description;
  final List<Chapter> chapters;

  factory Book.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final chaptersRaw = data['chapters'] as List<dynamic>? ?? [];

    return Book(
      id: doc.id,
      title: data['title'] as String,
      author: data['author'] as String,
      description: data['description'] as String,
      chapters: chaptersRaw
          .map((item) => Chapter.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'author': author,
        'description': description,
        'chapters': chapters.map((chapter) => chapter.toMap()).toList(),
      };
}
