import 'dart:async';

void main() {
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  Stream<int> result = numbers
      .map((n) => n * n)
      .where((n) => n % 2 == 0);

  result.listen((value) {
    print(value);
  });
}