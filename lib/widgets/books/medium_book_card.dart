import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

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
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
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
