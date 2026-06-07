// 1. Create an async function using Future + await
Future<void> fetchData() async {
  print('Fetching data from server...');
  
  // 2. Use Future.delayed() to simulate loading
  await Future.delayed(Duration(seconds: 2));
  print('Data fetched successfully!');
}

// 4. Create a simple Stream of integers
Stream<int> counterStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1)); // Delay 1 sec between emits
    yield i; 
  }
}

void main() async {
  print('--- Exercise 5: Async & Null Safety ---');

  // Wait for the async function to finish
  await fetchData();

  print('\n-- Null Safety Practice --');
  // 3. Practice null-safety operators (?, ??, !)
  String? nullableString; // Can be null
  
  // ? operator (conditional access)
  print('String length: ${nullableString?.length}'); 
  
  // ?? operator (default value if null)
  String safeString = nullableString ?? 'Default Value';
  print('Value with ??: $safeString');

  // ! operator (force unwrap - assuming it's not null now)
  nullableString = 'Dart is awesome';
  print('Force unwrap with !: ${nullableString!}');

  print('\n-- Stream Practice --');
  // Listen to values from Stream
  await for (int value in counterStream()) {
    print('Stream emitted: $value');
  }
  
  print('Done!');
}