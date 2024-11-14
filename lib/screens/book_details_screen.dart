import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/screens/questionnaire_screen.dart';
import 'package:anaquel/screens/reading_screen.dart';
import 'package:anaquel/screens/recommendations_books_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.userBook});

  final UserBook userBook;

  String convertStatus(UserBookStatus status) {
    switch (status) {
      case UserBookStatus.reading:
        return "Leyendo";
      case UserBookStatus.read:
        return "Leído";
      case UserBookStatus.notRead:
        return "No leído";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Detalles del libro"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        suffixActions: [
          CustomPopup(
            content: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      "Colecciones",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      "Borrar libro",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FAssets.icons.ellipsisVertical(),
            ),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 260,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 0.625,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: FAssets.icons.circleX(),
                    ),
                    imageUrl: userBook.coverUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 240,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userBook.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userBook.authors.join(", "),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
              ),
            ),
            const SizedBox(height: 16),
            FBadge(
              label: Text(convertStatus(userBook.status)),
              style: FBadgeStyle.secondary,
            ),
            const FDivider(),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ReadingScreen(),
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
              style: FButtonStyle.primary,
              label: const Text("Reanudar lectura"),
            ),
            const SizedBox(height: 8),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      QuestionnaireScreen(
                    bookId: userBook.id,
                    bookTitle: userBook.title,
                    bookAuthor: userBook.authors.join(", "),
                  ),
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
              style: FButtonStyle.outline,
              label: const Text("Cuestionario"),
            ),
            const SizedBox(height: 8),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const RecommendationsBooksScreen(),
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
              style: FButtonStyle.outline,
              label: const Text("Recomendaciones"),
            ),
            const FDivider(),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Descripción",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userBook.description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
              ),
            ),
            const FDivider(),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Géneros",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final genre in userBook.genres) AChip(label: genre),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
