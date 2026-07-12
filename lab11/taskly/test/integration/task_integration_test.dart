import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/main.dart' as app;

void main() {
  group('Taskly End-to-End Integration Flow', () {
    testWidgets('Should complete full lifecycle: Add -> Navigate -> Edit -> Save -> Verify', (WidgetTester tester) async {
      // 1. Arrange: Initialize app structure
      app.main();
      await tester.pumpAndSettle();

      // 2. Act: Add "Original title"
      await tester.enterText(find.byType(TextField), 'Original title');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text('Original title'), findsOneWidget);

      // 3. Act: Tap task to open detail screen
      await tester.tap(find.text('Original title'));
      await tester.pumpAndSettle();

      // 4. Act: Edit title fields to "Updated title"
      final detailInput = find.byKey(const Key('detailTitleField'));
      await tester.enterText(detailInput, 'Updated title');
      
      // 5. Act: Tap Save icon/button
      await tester.tap(find.byKey(const Key('saveDetailButton')));
      await tester.pumpAndSettle();

      // 6. Assert: Verify updated title reflects back on the list view
      expect(find.text('Updated title'), findsOneWidget);
      expect(find.text('Original title'), findsNothing);
    });
  });
}