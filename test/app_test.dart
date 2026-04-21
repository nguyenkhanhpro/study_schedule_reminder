import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_schedule_reminder/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('🔥 Auto Test - Quản lý học tập và nhắc nhở', () {
    testWidgets('TC01 - Đăng nhập thành công và chuyển sang Home', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Nhập email và password
      await tester.enterText(find.byType(TextField).at(0), 'user1@email.com');
      await tester.enterText(find.byType(TextField).at(1), '123456');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Kiểm tra đã vào màn hình Home
      expect(find.textContaining('All Schedule'), findsOneWidget);
      expect(find.textContaining('Xin chào, user1'), findsOneWidget);
    });

    testWidgets('TC02 - Thêm lịch học mới (Add Schedule)', (tester) async {
      await _login(tester);

      // Bấm nút +
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Kiểm tra có mở màn hình Add Schedule
      expect(find.text('Add Schedule'), findsOneWidget);

      // Nhập Subject
      await tester.enterText(find.byType(TextField).at(0), 'Lập trình Flutter');

      // Chọn Select section = Today
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Today').last);
      await tester.pumpAndSettle();

      // Nhập Time
      await tester.enterText(find.byType(TextField).at(2), '08:30');

      // Nhập Note
      await tester.enterText(find.byType(TextField).at(3), 'Học trên lớp');

      // Bấm Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Lưu lịch thành công'), findsOneWidget);
    });

    testWidgets('TC03 - Xem lịch Today (ngày 19/4/2026)', (tester) async {
      await _login(tester);

      // Giả lập bấm vào ngày 19 trên lịch
      await tester.tap(find.text('19'));
      await tester.pumpAndSettle();

      // Kiểm tra vào màn hình Today
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('07:00 - Python'), findsOneWidget);
      expect(find.text('Database'), findsOneWidget);
    });

    testWidgets('TC04 - Bấm vào sự kiện → Hiện thông báo "Đang cập nhật"', (tester) async {
      await _login(tester);
      await tester.tap(find.text('19'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Python'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Chức năng đang được cập nhật'), findsOneWidget);
    });

    testWidgets('TC05 - Đăng nhập sai → Hiển thị lỗi', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'sai@email.com');
      await tester.enterText(find.byType(TextField).at(1), '123');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Email hoặc mật khẩu không đúng'), findsOneWidget);
    });

    testWidgets('TC06 - Thêm lịch thiếu Subject → Báo lỗi', (tester) async {
      await _login(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Không nhập Subject, chỉ chọn section và time
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Today').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Vui lòng nhập Subject'), findsOneWidget);
    });
  });
}

// Hàm helper đăng nhập nhanh
Future<void> _login(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextField).at(0), 'user1@email.com');
  await tester.enterText(find.byType(TextField).at(1), '123456');

  await tester.tap(find.text('Login'));
  await tester.pumpAndSettle();
}