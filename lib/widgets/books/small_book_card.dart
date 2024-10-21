import 'package:anaquel/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SmallBookCard extends StatelessWidget {
  const SmallBookCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.author,
  });

  final String id;
  final String image;
  final String title;
  final String author;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/book/$id"),
      child: Container(
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
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: AppColors.antiFlashWhite,
                        highlightColor: AppColors.timberwolf,
                        child: Container(
                          color: AppColors.antiFlashWhite,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => Center(
                      child: FAssets.icons.circleX(),
                    ),
                    imageUrl: image,
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
      ),
    );
  }
}
