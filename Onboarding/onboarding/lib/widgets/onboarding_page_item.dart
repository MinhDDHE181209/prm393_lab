import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel pageData;

  const OnboardingPageItem({super.key, required this.pageData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Khối hiển thị hình ảnh tính năng dạng Card
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff1e1e1e),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(pageData.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Tiêu đề
          Text(
            pageData.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Đoạn mô tả chi tiết
          Text(
            pageData.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}