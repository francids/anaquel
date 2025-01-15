import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectionChip extends StatelessWidget {
  const CollectionChip({
    super.key,
    required this.label,
    required this.color,
    required this.onPress,
  });

  final String label;
  final Color color;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onPress(),
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
