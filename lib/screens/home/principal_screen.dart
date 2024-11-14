import 'package:anaquel/data/models/recommendation_book.dart';
import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/medium_book_card.dart';
import 'package:anaquel/widgets/books/recommendation_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<RecommendationBook> recommendations = [];
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
                    if (state.userBooks.any(
                      (userBook) => userBook.status == UserBookStatus.reading,
                    ))
                      Column(
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
                                  userBook: state.userBooks[index],
                                );
                              },
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 12);
                              },
                            ),
                          ),
                        ],
                      ),
                    if (state.userBooks.any(
                          (userBook) =>
                              userBook.status == UserBookStatus.notRead,
                        ) &&
                        state.userBooks.any(
                          (userBook) =>
                              userBook.status == UserBookStatus.reading,
                        ))
                      const FDivider(),
                    if (state.userBooks.any(
                      (userBook) => userBook.status == UserBookStatus.notRead,
                    ))
                      Column(
                        children: [
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
                                  userBook: state.userBooks[index],
                                );
                              },
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 12);
                              },
                            ),
                          ),
                        ],
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
        ],
      ),
    );
  }
}
