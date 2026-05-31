import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FirebaseService {
  FirebaseService._();

  static bool _initialized = false;

  static bool get isConfigured =>
      DefaultFirebaseOptions.android.apiKey != 'REPLACE_ME';

  static Future<void> initialize() async {
    if (_initialized) return;

    if (!isConfigured) {
      throw FirebaseException(
        plugin: 'firebase_core',
        message:
            'Chưa cấu hình Firebase. Chạy: flutterfire configure',
      );
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    _initialized = true;
  }
}
