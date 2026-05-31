import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  String? get uid => _auth.currentUser?.uid;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User> signInAnonymously() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser!;
    }

    final credential = await _auth.signInAnonymously();
    return credential.user!;
  }

  Future<String> requireUid() async {
    final user = await signInAnonymously();
    return user.uid;
  }
}
