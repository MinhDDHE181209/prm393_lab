import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff152d32),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'BIỂU ĐỒ PHÂN BỔ THỰC TẾ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 40, // Tạo lỗ rỗng biến Pie thành Donut Chart
                sections: [
                  _buildPieSection(color: const Color(0xffe63946), value: 35, title: '35%'),
                  _buildPieSection(color: const Color(0xff2ec4b6), value: 25, title: '25%'),
                  _buildPieSection(color: const Color(0xffffb703), value: 15, title: '15%'),
                  _buildPieSection(color: const Color(0xff8338ec), value: 25, title: '25%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'TỔNG CHI: 2.380.000.000 VNĐ',
            style: TextStyle(color: Color(0xff2ec4b6), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  PieChartSectionData _buildPieSection({required Color color, required double value, required String title}) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: title,
      radius: 25,
      titleStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
    );
  }
}