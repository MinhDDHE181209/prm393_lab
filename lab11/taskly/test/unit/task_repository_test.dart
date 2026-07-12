import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/repositories/task_repository.dart'; // Adjust path if needed

void main() {
  group('TaskRepository Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    test('addTask() should append a task to the repository list', () {
      // Arrange
      final task = Task(id: '1', title: 'New Task');

      // Act
      repository.addTask(task);

      // Assert
      expect(repository.getAllTasks().length, 1);
      expect(repository.getAllTasks().first.title, 'New Task');
    });

    test('deleteTask() should remove the specified task by ID', () {
      // Arrange
      final task1 = Task(id: '1', title: 'Task 1');
      final task2 = Task(id: '2', title: 'Task 2');
      repository.addTask(task1);
      repository.addTask(task2);

      // Act
      repository.deleteTask('1');

      // Assert
      expect(repository.getAllTasks().length, 1);
      expect(repository.getAllTasks().any((t) => t.id == '1'), isFalse);
    });

    test('updateTask() should modify properties of an existing task', () {
      // Arrange
      final task = Task(id: '1', title: 'Old Title');
      repository.addTask(task);

      // Act
      repository.updateTask('1', 'Updated Title');

      // Assert
      final updatedTask = repository.getAllTasks().firstWhere((t) => t.id == '1');
      expect(updatedTask.title, 'Updated Title');
    });
  });
}