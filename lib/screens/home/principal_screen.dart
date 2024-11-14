import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/medium_book_card.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          BlocBuilder<UserBooksBloc, UserBooksState>(
            builder: (context, state) {
              if (state is UserBooksLoading) {
                return const SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is UserBooksError) {
                return SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: FAlert(
                    icon: FAssets.icons.badgeX(),
                    title: const Text(
                            "principal_screen.error_loading_reading_books")
                        .tr(),
                    subtitle: Text(state.message),
                    style: FAlertStyle.destructive,
                  ),
                );
              }
              if (state is UserBooksLoaded) {
                if (state.userBooks.isEmpty) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: const Text(
                          "principal_screen.reading",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ).tr(),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FAlert(
                            icon: FAssets.icons.badgeInfo(),
                            title:
                                const Text("principal_screen.no_reading_books")
                                    .tr(),
                            subtitle:
                                const Text("principal_screen.no_to_read_books")
                                    .tr(),
                            style: FAlertStyle.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: const Text(
                        "principal_screen.reading",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ).tr(),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.userBooks.length,
                        itemBuilder: (context, index) {
                          return MediumBookCard(
                            id: state.userBooks[index].id,
                            image: state.userBooks[index].coverUrl,
                          );
                        },
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 12);
                        },
                      ),
                    ),
                    const FDivider(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: const Text(
                        "principal_screen.to_read",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ).tr(),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.userBooks.length,
                        itemBuilder: (context, index) {
                          return MediumBookCard(
                            id: state.userBooks[index].id,
                            image: state.userBooks[index].coverUrl,
                          );
                        },
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 12);
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const FDivider(),
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    "principal_screen.recommendations",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ).tr(),
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
