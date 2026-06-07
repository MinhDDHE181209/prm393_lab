import 'package:flutter/material.dart';
import '../models/financial_item_model.dart';
import '../widgets/input_form_section.dart';
import '../widgets/cost_item_card.dart';
import '../widgets/chart_section.dart';

class FinancialPlanScreen extends StatefulWidget {
  const FinancialPlanScreen({super.key});

  @override
  State<FinancialPlanScreen> createState() => _FinancialPlanScreenState();
}

class _FinancialPlanScreenState extends State<FinancialPlanScreen> {
  String _selectedProjectType = 'Mô hình Cafe';
  double _budget = 2500000000;

  // Mock data danh sách chi phí được quản lý tập trung thông qua Model vừa tạo
  final List<FinancialItemModel> _costItems = const [
    FinancialItemModel(title: 'Thuê Mặt Bằng', amount: 2500000, tag: 'Sắp thu', color: Color(0xff104f55)),
    FinancialItemModel(title: 'Thiết Kế & Thi công', amount: 1000000, tag: 'Thu nhận', color: Color(0xff7f4f24)),
    FinancialItemModel(title: 'Thiết Bị & Máy Móc', amount: 1000000, tag: 'Tái cấu', color: Color(0xff9a7b56)),
    FinancialItemModel(title: 'Nguyên liệu đầu vào', amount: 12000000, tag: 'Vật tư', color: Color(0xff3f5e4d)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b1e),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWideScreen = constraints.maxWidth > 950;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LẬP KẾ HOẠCH TÀI CHÍNH DỰ ÁN',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                  ),
                  const SizedBox(height: 20),
                  isWideScreen ? _buildHorizontalLayout() : _buildVerticalLayout(),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // Bố cục hàng ngang tối ưu cho màn hình rộng / PC / Tablet
  Widget _buildHorizontalLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: InputFormSection(
            selectedProjectType: _selectedProjectType,
            budget: _budget,
            onProjectTypeChanged: (val) => setState(() => _selectedProjectType = val!),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(flex: 4, child: _buildMiddleColumn()),
        const SizedBox(width: 16),
        Expanded(flex: 4, child: const ChartSection()),
      ],
    );
  }

  // Bố cục hàng dọc tối ưu cho thiết bị di động dáng đứng (Mobile)
  Widget _buildVerticalLayout() {
    return Column(
      children: [
        InputFormSection(
          selectedProjectType: _selectedProjectType,
          budget: _budget,
          onProjectTypeChanged: (val) => setState(() => _selectedProjectType = val!),
        ),
        const SizedBox(height: 16),
        _buildMiddleColumn(),
        const SizedBox(height: 16),
        const ChartSection(),
      ],
    );
  }

  // Khối cột ở giữa xử lý thanh Slider ngân sách và render danh sách Card
  Widget _buildMiddleColumn() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xff152d32), borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DỰ TRÙ NGÂN SÁCH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Slider(
                value: _budget,
                min: 1000000000,
                max: 5000000000,
                activeColor: const Color(0xff2ec4b6),
                inactiveColor: Colors.grey.shade800,
                onChanged: (value) => setState(() => _budget = value),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Sử dụng toán tử trải mảng từ danh sách model cực kỳ chuyên nghiệp
        ..._costItems.map((item) => CostItemCard(item: item)),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff112529),
      selectedItemColor: const Color(0xff2ec4b6),
      unselectedItemColor: Colors.grey,
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Dự án'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Báo cáo'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
      ],
    );
  }
}