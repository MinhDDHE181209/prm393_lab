import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';

class FirestoreProgressService {
  FirestoreProgressService({
    FirebaseFirestore? firestore,
    AuthService? authService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _authService = authService ?? AuthService();

  final FirebaseFirestore _firestore;
  final AuthService _authService;

  Future<DocumentReference<Map<String, dynamic>>> _doc(String bookId) async {
    final uid = await _authService.requireUid();
    return _firestore.collection('users').doc(uid).collection('progress').doc(bookId);
  }

  Future<double> getScrollOffset(String bookId, String chapterId) async {
    final docRef = await _doc(bookId);
    final snapshot = await docRef.get(const GetOptions(source: Source.cache));
    if (!snapshot.exists) {
      final serverSnapshot =
          await docRef.get(const GetOptions(source: Source.server));
      return _readOffset(serverSnapshot, chapterId);
    }
    return _readOffset(snapshot, chapterId);
  }

  double _readOffset(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    String chapterId,
  ) {
    if (!snapshot.exists) return 0;
    final offsets = snapshot.data()?['offsets'] as Map<String, dynamic>? ?? {};
    final value = offsets[chapterId];
    if (value is num) return value.toDouble();
    return 0;
  }

  Future<String?> getLastChapterId(String bookId) async {
    final docRef = await _doc(bookId);
    final snapshot = await docRef.get(const GetOptions(source: Source.cache));
    if (snapshot.exists) {
      return snapshot.data()?['lastChapterId'] as String?;
    }

    final serverSnapshot =
        await docRef.get(const GetOptions(source: Source.server));
    if (!serverSnapshot.exists) return null;
    return serverSnapshot.data()?['lastChapterId'] as String?;
  }

  Future<void> saveScrollOffset(
    String bookId,
    String chapterId,
    double offset,
  ) async {
    final docRef = await _doc(bookId);
    await docRef.set(
      {
        'offsets': {chapterId: offset},
        'lastChapterId': chapterId,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> saveLastChapter(String bookId, String chapterId) async {
    final docRef = await _doc(bookId);
    await docRef.set(
      {'lastChapterId': chapterId},
      SetOptions(merge: true),
    );
  }

  Stream<String?> watchLastChapterId(String bookId) async* {
    final docRef = await _doc(bookId);
    yield* docRef.snapshots(includeMetadataChanges: true).map(
          (snapshot) => snapshot.data()?['lastChapterId'] as String?,
        );
  }
}
