import 'package:anaquel/widgets/books/medium_book_card.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

List<String> _bookCovers = [
  "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
  "https://images.squarespace-cdn.com/content/v1/624da83e75ca872f189ffa42/aa45e942-f55d-432d-8217-17c7d98105ce/image001.jpg",
  "https://images.squarespace-cdn.com/content/v1/5fc7868e04dc9f2855c99940/32f738d4-e4b9-4c61-bfc0-e813699cdd3c/laura-barrett-illustrator-beloved-girls-book-cover.jpg",
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/yellow-the-mind-of-a-leader-book-cover-design-template-f3cc2996f5f381d3d2d092e2d67337a4_screen.jpg"
];

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Tu progreso",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FDivider(),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Tus libros",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 240,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _bookCovers.length,
              itemBuilder: (context, index) {
                return MediumBookCard(image: _bookCovers[index]);
              },
              padding: const EdgeInsets.only(left: 16, right: 16),
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                FDivider(),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Recomendaciones",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
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
