import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';

class AChip extends StatelessWidget {
  const AChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.antiFlashWhite,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label),
    );
  }
}
