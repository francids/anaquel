import 'dart:io';

import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';

class LocalSmallBookCard extends StatelessWidget {
  const LocalSmallBookCard({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.author,
  });

  final String coverUrl;
  final String title;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.antiFlashWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 0.625,
                child: Image.file(
                  File(coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.eerieBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  author,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.eerieBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
