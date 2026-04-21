import 'package:flutter/material.dart';
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