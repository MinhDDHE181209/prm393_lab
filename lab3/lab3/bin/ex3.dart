import 'dart:async';

void main() {
  print('--- Exercise 3: Async + Microtask Debugging ---');

  // 1. Snippet with synchronous code, scheduleMicrotask(), and standard Future
  print('Step 1: Standard Synchronous Log (Main Starts)');

  // Standard Future task targeting the Event Queue
  Future(() {
    print('Step 5: Event Queue task executed (Standard Future callback)');
  });

  // Microtask targeting the high-priority Microtask Queue
  scheduleMicrotask(() {
    print('Step 3: Microtask Queue task executed (via scheduleMicrotask)');
  });

  // Another Microtask task triggered implicitly via Future.value().then
  Future.value().then((_) {
    print('Step 4: Microtask Queue task executed (via Future.value().then)');
  });

  print('Step 2: Standard Synchronous Log (Main Ends)');


}