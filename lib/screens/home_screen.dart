import 'package:flutter/material.dart';
import 'package:study_schedule_reminder/models/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime(2026, 4, 19);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF007AFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'All Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Xin chào, ${widget.user.email.split('@')[0]} 👋',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
      
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
      
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'You have 6 event in today',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      
          // Month & Year
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'April 2026',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.arrow_drop_up, size: 30),
                    Icon(Icons.arrow_drop_down, size: 30),
                  ],
                ),
              ],
            ),
          ),
      
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // Weekday headers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('SU', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('MO', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('TU', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('WE', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('TH', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('FR', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('SA', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
      
                  const SizedBox(height: 8),
      
                  // Calendar Grid
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 8,   // Giãn ngang
                        mainAxisSpacing: 8,    // Giãn dọc
                        childAspectRatio: 1,
                      ),
                      itemCount: 42,
                      itemBuilder: (context, index) {
                        int day = index - 2;
                        if (day < 1) day += 31;
                        if (day > 30) day -= 30;
      
                        bool isSelected = day == _selectedDate.day;
      
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = DateTime(2026, 4, day);
                            });
                          },
                          child: Container(
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      
          // Add Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                elevation: 4,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thêm sự kiện mới...')),
                  );
                },
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}