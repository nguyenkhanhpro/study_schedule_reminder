import 'package:flutter/material.dart';
import 'package:study_schedule_reminder/models/user.dart';
import 'add_schedule_screen.dart';   // Import màn hình thêm lịch

class TodayScreen extends StatelessWidget {
  final User user;
  final DateTime selectedDate;

  const TodayScreen({
    super.key,
    required this.user,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    bool isToday = selectedDate.day == 19 &&
        selectedDate.month == 4 &&
        selectedDate.year == 2026;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007AFF),
        elevation: 0,
        title: const Text('Today', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isToday ? _buildTodayContent(context) : _buildNoUpdateContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _goToAddSchedule(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ================= NỘI DUNG KHI LÀ NGÀY 19 =================
  Widget _buildTodayContent(BuildContext context) {
    return Column(
      children: [
        // Next card
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  '07:00 - Python',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),

        // Danh sách sự kiện
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              EventTile(time: '07:00', title: 'Python'),
              EventTile(time: '13:00', title: 'Database'),
              EventTile(time: '15:00', title: 'AI'),
              EventTile(time: '18:00', title: 'Tiếng Anh'),
              EventTile(time: '20:00', title: 'Ôn tập'),
              EventTile(time: '22:00', title: 'Nghe tiếng anh'),
            ],
          ),
        ),
      ],
    );
  }

  // ================= NỘI DUNG KHI CHỌN NGÀY KHÁC =================
  Widget _buildNoUpdateContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.event_busy, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Chưa update',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Chưa có lịch cho ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ================= CHUYỂN ĐẾN MÀN HÌNH THÊM LỊCH =================
  void _goToAddSchedule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddScheduleScreen(user: user),
      ),
    );
  }
}

// ================= WIDGET MỖI SỰ KIỆN =================
class EventTile extends StatelessWidget {
  final String time;
  final String title;

  const EventTile({
    super.key,
    required this.time,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Chức năng đang được cập nhật...'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}