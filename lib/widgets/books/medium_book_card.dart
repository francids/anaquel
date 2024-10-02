import 'package:flutter/material.dart';

class MediumBookCard extends StatelessWidget {
  const MediumBookCard({super.key, required this.image, required this.onPress});

  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              width: 125,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
