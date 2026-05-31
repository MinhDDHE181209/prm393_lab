import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/seed_books.dart';
import '../models/book.dart';

class BooksSnapshot {
  const BooksSnapshot({
    required this.books,
    required this.isFromCache,
  });

  final List<Book> books;
  final bool isFromCache;
}

class FirestoreBookService {
  FirestoreBookService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _books =>
      _firestore.collection('books');

  Stream<BooksSnapshot> watchBooks() {
    return _books.orderBy('title').snapshots(includeMetadataChanges: true).map(
      (snapshot) {
        return BooksSnapshot(
          books: snapshot.docs.map(Book.fromFirestore).toList(),
          isFromCache: snapshot.metadata.isFromCache,
        );
      },
    );
  }

  Future<Book?> getBook(String bookId) async {
    final doc = await _books.doc(bookId).get(const GetOptions(source: Source.cache));
    if (doc.exists) {
      return Book.fromFirestore(doc);
    }

    final serverDoc =
        await _books.doc(bookId).get(const GetOptions(source: Source.server));
    if (!serverDoc.exists) return null;
    return Book.fromFirestore(serverDoc);
  }

  Future<void> seedIfEmpty() async {
    final snapshot = await _books.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    final batch = _firestore.batch();
    for (final book in SeedBooks.all) {
      batch.set(_books.doc(book.id), book.toMap());
    }
    await batch.commit();
  }
}
