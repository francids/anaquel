import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/data/services/recommendation_service.dart';
import 'package:anaquel/widgets/books/recommendation_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class RecommendationsBooksScreen extends StatelessWidget {
  RecommendationsBooksScreen({
    super.key,
    required this.userBook,
  });

  final RecommendationService recommendationService = RecommendationService();
  final UserBook userBook;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(userBook.title),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: const Text(
                "recommendations_screen.title",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
            ),
            const SizedBox(height: 16),
            FutureBuilder(
              future: recommendationService.getRecommendations(
                userBook.id.toString(),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return FAlert(
                      icon: FIcon(FAssets.icons.badgeX),
                      title: const Text(
                        "recommendations_screen.error",
                      ).tr(),
                      style: FAlertStyle.destructive,
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return FAlert(
                      icon: FIcon(FAssets.icons.badgeInfo),
                      title: const Text(
                        "recommendations_screen.no_recommendations",
                      ).tr(),
                      style: FAlertStyle.primary,
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: snapshot.data!.length > 10
                          ? 10
                          : snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return RecommendationBookCard(
                          book: snapshot.data![index],
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
