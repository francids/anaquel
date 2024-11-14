import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/screens/book_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shimmer/shimmer.dart';

class LargeBookCard extends StatelessWidget {
  const LargeBookCard({
    super.key,
    required this.userBook,
  });

  final UserBook userBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BookDetailsScreen(userBook: userBook),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
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
                  imageUrl: userBook.coverUrl,
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
                userBook.title,
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
