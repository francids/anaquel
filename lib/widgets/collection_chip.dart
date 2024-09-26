import 'package:flutter/material.dart';

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
    return GestureDetector(
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
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
