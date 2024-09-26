import 'package:flutter/material.dart';

class MediumBookCard extends StatelessWidget {
  const MediumBookCard({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            width: 150,
            height: 240,
          ),
        ],
      ),
    );
  }
}
