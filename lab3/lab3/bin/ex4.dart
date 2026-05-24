import 'dart:async';

void main() async {
  print('--- Exercise 4: Stream Transformation ---');

  // 1. Create a raw stream of numbers 1 to 5
  Stream<int> rawNumbersStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Applying stream transformations...');

  // 2 & 3. Transform values to squares using map(), and filter even numbers with where()
  Stream<int> transformedStream = rawNumbersStream
      .map((number) {
        // Square the incoming number emission
        return number * number;
      })
      .where((squaredValue) {
        // Keep only even square numbers
        return squaredValue % 2 == 0;
      });

  // 4. Listen and print each emitted value
  print('Starting subscription/listening to transformed results:');
  
  await transformedStream.forEach((value) {
    print('Emitted Processed Event -> Value: $value');
  });

  print('Stream lifecycle closed safely.');
}