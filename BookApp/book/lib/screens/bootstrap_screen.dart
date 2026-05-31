import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/firebase_service.dart';
import '../services/firestore_book_service.dart';
import 'home_screen.dart';

class BootstrapScreen extends StatefulWidget {
  const BootstrapScreen({super.key});

  @override
  State<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    setState(() => _error = null);

    try {
      if (!FirebaseService.isConfigured) {
        throw Exception(
          'Chưa cấu hình Firebase.\n\n'
          '1. Tạo project tại console.firebase.google.com\n'
          '2. Thêm app Android (com.example.book)\n'
          '3. Tải google-services.json vào android/app/\n'
          '4. Bật Firestore + Anonymous Auth\n'
          '5. Chạy: dart pub global activate flutterfire_cli\n'
          '6. Chạy: flutterfire configure\n'
          '7. Dán firestore.rules vào Firebase Console\n'
          '8. flutter run lại',
        );
      }

      await FirebaseService.initialize();
      await AuthService().signInAnonymously();
      await FirestoreBookService().seedIfEmpty();

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (error) {
      if (mounted) {
        setState(() => _error = error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cần cấu hình Firebase')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.cloud_off,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: _initialize,
                icon: const Icon(Icons.refresh),
                label: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Đang kết nối Firebase...'),
          ],
        ),
      ),
    );
  }
}
