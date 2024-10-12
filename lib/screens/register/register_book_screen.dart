import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/widgets/books/register_small_book_card.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:scaled_app/scaled_app.dart';

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

class RegisterBookScreen extends StatelessWidget {
  const RegisterBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: FTheme(
        data: FThemes.zinc.light,
        child: FScaffold(
          header: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: FHeader.nested(
              title: const Text("Registrando libro"),
              leftActions: [
                FHeaderAction.back(
                  onPress: () => context.pop(),
                ),
              ],
            ),
          ),
          contentPad: false,
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                FButton(
                  onPress: () {},
                  style: FButtonStyle.outline,
                  label: const Text("Crear libro"),
                ),
                const FDivider(),
                FTextField(
                  hint: "Buscar libro",
                  suffix: Container(
                    padding: const EdgeInsets.all(12),
                    child: FAssets.icons.search(),
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
                      return RegisterSmallBookCard(
                        id: index.toString(),
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
        ),
      ),
    );
  }
}
