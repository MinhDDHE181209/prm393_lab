import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bookmark.dart';
import 'auth_service.dart';

class FirestoreBookmarkService {
  FirestoreBookmarkService({
    FirebaseFirestore? firestore,
    AuthService? authService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _authService = authService ?? AuthService();

  final FirebaseFirestore _firestore;
  final AuthService _authService;

  Future<CollectionReference<Map<String, dynamic>>> _collection() async {
    final uid = await _authService.requireUid();
    return _firestore.collection('users').doc(uid).collection('bookmarks');
  }

  Stream<List<Bookmark>> watchBookmarksForBook(String bookId) async* {
    final collection = await _collection();
    yield* collection
        .where('bookId', isEqualTo: bookId)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      final bookmarks = snapshot.docs.map(Bookmark.fromFirestore).toList();
      bookmarks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return bookmarks;
    });
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    final collection = await _collection();
    await collection.doc(bookmark.id).set(bookmark.toMap());
  }

  Future<void> removeBookmark(String bookmarkId) async {
    final collection = await _collection();
    await collection.doc(bookmarkId).delete();
  }
}
