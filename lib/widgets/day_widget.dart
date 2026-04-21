import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final int day;
  final bool isSelected;

  const CalendarDay({
    super.key,
    required this.day,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.grey[900] : null,
        border: isSelected
            ? Border.all(color: Colors.grey[700]!, width: 2)
            : null,
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            fontSize: 17,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}