import 'package:anaquel/data/models/recommendation_book.dart';
import 'package:anaquel/widgets/books/recommendation_book_card.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class RecommendationsBooksScreen extends StatelessWidget {
  const RecommendationsBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<RecommendationBook> recommendations = [];
    return FScaffold(
      header: FHeader.nested(
        title: const Text("really good, actually"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        suffixActions: [
          FHeaderAction(
            icon: FAssets.icons.rotateCcw(),
            onPress: () {},
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Recomendaciones",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  return RecommendationBookCard(
                    book: recommendations[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
