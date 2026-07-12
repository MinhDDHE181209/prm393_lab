import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/models/task.dart'; // Adjust path if needed

void main() {
  group('Task Model Tests', () {
    test('Should have default completed status as false', () {
      // Arrange & Act
      final task = Task(id: '1', title: 'Test Task');

      // Assert
      expect(task.isCompleted, isFalse);
    });

    test('toggle() should switch isCompleted true ↔ false', () {
      // Arrange
      final task = Task(id: '1', title: 'Test Task');

      // Act & Assert (False -> True)
      task.toggle();
      expect(task.isCompleted, isTrue);

      // Act & Assert (True -> False)
      task.toggle();
      expect(task.isCompleted, isFalse);
    });
  });
}