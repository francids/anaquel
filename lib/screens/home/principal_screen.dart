import 'package:anaquel/widgets/books/medium_book_card.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:anaquel/widgets/mini_tab.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

List<String> _bookCovers = [
  "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
  "https://images.squarespace-cdn.com/content/v1/624da83e75ca872f189ffa42/aa45e942-f55d-432d-8217-17c7d98105ce/image001.jpg",
  "https://images.squarespace-cdn.com/content/v1/5fc7868e04dc9f2855c99940/32f738d4-e4b9-4c61-bfc0-e813699cdd3c/laura-barrett-illustrator-beloved-girls-book-cover.jpg",
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/yellow-the-mind-of-a-leader-book-cover-design-template-f3cc2996f5f381d3d2d092e2d67337a4_screen.jpg"
];

List<String> _bookTitles = [
  "SOUL",
  "really good, actually",
  "The Beloved Girls",
  "The Mind of a Leader",
];

List<String> _bookAuthors = [
  "Olivia Wilson",
  "Monica Heisey",
  "Harriet Evans",
  "Nouah Schumacher",
];

List<String> _bookStatus = [
  "Leyendo",
  "Por leer",
];

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Tus libros",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final status in _bookStatus)
                        MiniTab(
                          label: status,
                          isSelected: status == "Leyendo",
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _bookCovers.length,
              itemBuilder: (context, index) {
                return MediumBookCard(
                  id: index.toString(),
                  image: _bookCovers[index],
                );
              },
              padding: const EdgeInsets.only(left: 16, right: 16),
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const FDivider(),
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
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
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
        ],
      ),
    );
  }
}
