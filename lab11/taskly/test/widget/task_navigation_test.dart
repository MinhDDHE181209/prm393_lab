import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/screens/task_list_screen.dart';

void main() {
  testWidgets('Tapping a task tile navigates to TaskDetailScreen with expected fields', (WidgetTester tester) async {
    // Arrange: Create screen and pass a repository seeded with a task
    // (Ensure your screen UI allows dependency injection or initial seeding)
    final seededTask = Task(id: '101', title: 'Seeded Navigation Task');
    
    await tester.pumpWidget(
      MaterialApp(
        home: TaskListScreen(initialTasks: [seededTask]),
      ),
    );

    // Act: Tap on the seeded task list item and wait for transition animation to finish
    await tester.tap(find.text('Seeded Navigation Task'));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Task Detail'), findsOneWidget); // Verifies AppBar title
    expect(find.byKey(const Key('detailTitleField')), findsOneWidget); // Verifies input field key
  });
}