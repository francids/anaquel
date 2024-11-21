import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class CollectionChip extends StatelessWidget {
  const CollectionChip(
      {super.key,
      required this.label,
      required this.color,
      required this.onPress});

  final String label;
  final Color color;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      rippleBorderRadius: BorderRadius.circular(8),
      onTap: () => onPress(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: color,
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
