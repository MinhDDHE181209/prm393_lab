import 'package:flutter/material.dart';
import '../models/financial_item_model.dart';

class CostItemCard extends StatelessWidget {
  final FinancialItemModel item;

  const CostItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final String formattedAmount = item.amount
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    return Card(
      color: const Color(0xff152d32),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 4,
          height: 30,
          decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(2)),
        ),
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          'Estimated $formattedAmount đ',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: item.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            item.tag,
            style: TextStyle(color: item.color, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}