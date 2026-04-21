import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_schedule_reminder/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests - Study Schedule Reminder', () {

    testWidgets('TC01 - Login -> Home -> Today -> Add Schedule', (tester) async {

      // Start app
      app.main();
      await tester.pumpAndSettle();

      // LOGIN
      await tester.enterText(
        find.byType(TextField).at(0),
        'test@gmail.com',
      );
      await tester.enterText(
        find.byType(TextField).at(1),
        '123456',
      );

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify Home
      expect(find.text('All Schedule'), findsOneWidget);

      // Tap ngày 19
      final day19 = find.text('19');
      expect(day19, findsWidgets);

      await tester.tap(day19.first);
      await tester.pumpAndSettle();

      // Verify đã vào TodayScreen (check AppBar)
      expect(find.text('Today'), findsOneWidget);

      // Tap nút +
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);

      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Verify sang màn Add
      expect(find.text('Add Schedule'), findsOneWidget);

      //  Nhập Subject
      await tester.enterText(
        find.byType(TextField).first,
        'Test Integration',
      );

      // Chọn dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Today').last);
      await tester.pumpAndSettle();

      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Sau khi save quay lại TodayScreen
      expect(find.text('Today'), findsOneWidget);

    });

  });
}