import 'package:anaquel/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class MediumBookCard extends StatelessWidget {
  const MediumBookCard({
    super.key,
    required this.id,
    required this.image,
  });

  final String id;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/book/$id"),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            CachedNetworkImage(
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
              width: 125,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
