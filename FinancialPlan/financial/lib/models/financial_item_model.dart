import 'package:flutter/material.dart';

class FinancialItemModel {
  final String title;
  final double amount;
  final String tag;
  final Color color;

  const FinancialItemModel({
    required this.title,
    required this.amount,
    required this.tag,
    required this.color,
  });
}