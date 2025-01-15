import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/screens/book_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shimmer/shimmer.dart';

class SmallBookCard extends StatelessWidget {
  const SmallBookCard({
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
                      imageUrl: userBook.coverUrl,
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
                      userBook.title,
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
                      userBook.authors.join(", "),
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
      ),
    );
  }
}
