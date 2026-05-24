// 1. Create a Settings class with a private constructor
class Settings {
  String themeMode;
  bool notificationsEnabled;

  // Private named constructor prevents external raw instantiation
  Settings._internal({required this.themeMode, required this.notificationsEnabled}) {
    print('[_internal] Private constructor executed. Creating the single core instance.');
  }

  // Internal static cache reference holding the single instance (Eager initialization)
  static final Settings _cache = Settings._internal(
    themeMode: 'Dark Theme',
    notificationsEnabled: true,
  );

  // 2. Add a factory Settings() constructor that returns the singleton instance
  factory Settings() {
    // Instead of instantiating a new object, we return the existing cached instance
    return _cache;
  }
}

void main() {
  print('--- Exercise 5: Factory Constructors & Cache ---');

  // Requesting instances using the factory constructor
  print('Requesting instance A...');
  Settings instanceA = Settings();

  print('Requesting instance B...');
  Settings instanceB = Settings();

  // Modify configuration value via instance A
  instanceA.themeMode = 'Light Theme';

  print('\n--- Singleton Verification ---');
  print('Instance A Theme setting: ${instanceA.themeMode}');
  print('Instance B Theme setting: ${instanceB.themeMode} (Reflected automatically)');

  // 3. Verify two instances refer to the exact same memory object block
  bool checkingIdentity = identical(instanceA, instanceB);
  print('Result of identical(instanceA, instanceB) -> $checkingIdentity'); 
}