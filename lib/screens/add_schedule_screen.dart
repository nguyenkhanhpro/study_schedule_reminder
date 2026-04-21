import 'package:flutter/material.dart';
import 'package:study_schedule_reminder/models/user.dart';

class AddScheduleScreen extends StatefulWidget {
  final User user;

  const AddScheduleScreen({super.key, required this.user});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _subjectController = TextEditingController();
  final _timeController = TextEditingController(text: '07:00');
  final _noteController = TextEditingController();

  // 3 lựa chọn cho Select section
  final List<String> _sections = [
    'Today',
    'Day of week',
    'Choose',
  ];

  String? _selectedSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007AFF),
        elevation: 0,
        title: const Text('Add Schedule', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Subject
            _buildTextField('Subject', _subjectController, Icons.book),

            const SizedBox(height: 16),
            _buildDropdownSection(),
            const SizedBox(height: 16),

            // Time
            _buildTextField('Time (07:00)', _timeController, Icons.access_time),

            const SizedBox(height: 16),

            // Note
            _buildTextField('Note', _noteController, Icons.note, maxLines: 4),

            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saveSchedule,
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextField widget
  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  // Dropdown Select Section
  Widget _buildDropdownSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedSection,
        decoration: InputDecoration(
          labelText: 'Select section',
          prefixIcon: Icon(Icons.category, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        dropdownColor: Colors.white,
        items: _sections.map((String section) {
          return DropdownMenuItem<String>(
            value: section,
            child: Text(section),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedSection = newValue;
          });
        },
      ),
    );
  }

  void _saveSchedule() {
    if (_subjectController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập Subject')),
      );
      return;
    }
    if (_selectedSection == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn section')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lưu lịch thành công!')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _timeController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}