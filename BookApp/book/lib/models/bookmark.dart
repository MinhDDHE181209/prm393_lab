import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  const Bookmark({
    required this.id,
    required this.bookId,
    required this.chapterId,
    required this.chapterTitle,
    required this.scrollOffset,
    required this.preview,
    required this.createdAt,
  });

  final String id;
  final String bookId;
  final String chapterId;
  final String chapterTitle;
  final double scrollOffset;
  final String preview;
  final DateTime createdAt;

  factory Bookmark.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return Bookmark(
      id: doc.id,
      bookId: data['bookId'] as String,
      chapterId: data['chapterId'] as String,
      chapterTitle: data['chapterTitle'] as String,
      scrollOffset: (data['scrollOffset'] as num).toDouble(),
      preview: data['preview'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'bookId': bookId,
        'chapterId': chapterId,
        'chapterTitle': chapterTitle,
        'scrollOffset': scrollOffset,
        'preview': preview,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
