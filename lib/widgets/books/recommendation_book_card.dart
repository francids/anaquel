import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/recommendation_book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';

class RecommendationBookCard extends StatelessWidget {
  const RecommendationBookCard({
    super.key,
    required this.book,
  });

  final RecommendationBook book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/register_book/${book.id}"),
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
                    imageUrl: book.coverUrl,
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
                    book.title,
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
                    book.authors.join(", "),
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
