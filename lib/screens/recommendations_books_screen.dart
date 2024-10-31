import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> _bookCovers = [];
List<String> _bookTitles = [];
List<String> _bookAuthors = [];

class RecommendationsBooksScreen extends StatelessWidget {
  const RecommendationsBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("really good, actually"),
        leftActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        rightActions: [
          FHeaderAction(
            icon: FAssets.icons.rotateCcw,
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
                itemCount: _bookTitles.length,
                itemBuilder: (context, index) {
                  return SmallBookCard(
                    id: index,
                    image: _bookCovers[index],
                    title: _bookTitles[index],
                    author: _bookAuthors[index],
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
