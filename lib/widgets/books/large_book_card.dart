import 'package:anaquel/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class LargeBookCard extends StatelessWidget {
  const LargeBookCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
  });

  final String id;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/book/$id"),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 0.625,
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return Container(
                      color: AppColors.antiFlashWhite,
                    );
                  },
                  errorWidget: (context, url, error) => Center(
                    child: FAssets.icons.circleX(),
                  ),
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.eerieBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
