import 'package:flutter/material.dart';

class InputFormSection extends StatelessWidget {
  final String selectedProjectType;
  final double budget;
  final ValueChanged<String?> onProjectTypeChanged;

  const InputFormSection({
    super.key,
    required this.selectedProjectType,
    required this.budget,
    required this.onProjectTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Định dạng hiển thị tiền tệ (Ví dụ: 2.500.000.000)
    final String formattedBudget = budget
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff152d32),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LOẠI DỰ ÁN',
            style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedProjectType,
            dropdownColor: const Color(0xff152d32),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xff0d1b1e),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(value: 'Mô hình Cafe', child: Text('Mô hình Cafe')),
              DropdownMenuItem(value: 'Startup Công nghệ', child: Text('Startup Công nghệ')),
              DropdownMenuItem(value: 'Kinh doanh Bán lẻ', child: Text('Kinh doanh Bán lẻ')),
            ],
            onChanged: onProjectTypeChanged,
          ),
          const SizedBox(height: 20),
          const Text(
            'NGÂN SÁCH DỰ TRÙ',
            style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '$formattedBudget VNĐ',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Ngân input',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xff0d1b1e),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}