import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_page_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<OnboardingModel> _pages = OnboardingModel.getPages();
  bool _isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) => setState(() => _isLastPage = index == _pages.length - 1),
          itemBuilder: (context, index) => OnboardingPageItem(pageData: _pages[index]),
        ),
      ),
      bottomSheet: _buildBottomControls(),
    );
  }

  // Tách riêng AppBar thành một hàm widget nhỏ
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text('GIỚI THIỆU TÍNH NĂNG', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      centerTitle: true,
    );
  }

  // Tách phần điều khiển ở đáy thành một hàm widget nhỏ
  Widget _buildBottomControls() {
    return Container(
      color: const Color(0xff121212),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút bỏ qua nhanh
          TextButton(
            onPressed: () => _pageController.jumpToPage(_pages.length - 1),
            child: const Text('BỎ QUA', style: TextStyle(color: Colors.grey)),
          ),
          
          // Thanh chỉ báo chấm tròn
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: const WormEffect(
              spacing: 8.0,
              dotWidth: 10.0,
              dotHeight: 10.0,
              dotColor: Colors.grey,
              activeDotColor: Color(0xffa855f7),
            ),
          ),
          
          // Nút bấm hành động chuyển tiếp hoặc kết thúc
          _isLastPage ? _buildGetStartedButton() : _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffa855f7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        // Xử lý chuyển tiếp sang luồng ứng dụng chính
      },
      child: const Text('BẮT ĐẦU', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildNextButton() {
    return TextButton(
      onPressed: () => _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
      child: const Text('TIẾP THEO', style: TextStyle(color: Color(0xffa855f7))),
    );
  }
}