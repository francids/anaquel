import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/screens/book_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shimmer/shimmer.dart';

class MediumBookCard extends StatelessWidget {
  const MediumBookCard({
    super.key,
    required this.userBook,
  });

  final UserBook userBook;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BookDetailsScreen(userBook: userBook),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
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
                imageUrl: userBook.coverUrl,
                fit: BoxFit.cover,
                width: 125,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
