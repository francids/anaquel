import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/medium_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key, required this.onShowAllBooks});

  final VoidCallback onShowAllBooks;

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
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    "principal_screen.welcome",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ).tr(),
                ),
                const SizedBox(height: 16),
                FCard.raw(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "principal_screen.message",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ).tr(),
                        FButton.icon(
                          onPress: onShowAllBooks,
                          child: FIcon(FAssets.icons.chevronRight),
                        ),
                      ],
                    ),
                  ),
                ),
                // const FDivider(),
              ],
            ),
          ),
          // BlocBuilder<UserBooksBloc, UserBooksState>(
          //   buildWhen: (previous, current) => true,
          //   builder: (context, state) {
          //     if (state is UserBooksLoading) {
          //       return const SizedBox(
          //         width: double.infinity,
          //         height: 200,
          //         child: Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     }
          //     if (state is UserBooksError) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16),
          //         child: SizedBox(
          //           width: double.infinity,
          //           child: FAlert(
          //             icon: FAssets.icons.badgeX(),
          //             title: const Text(
          //                     "principal_screen.error_loading_reading_books")
          //                 .tr(),
          //             subtitle: Text(state.message),
          //             style: FAlertStyle.destructive,
          //           ),
          //         ),
          //       );
          //     }
          //     if (state is UserBooksLoaded) {
          //       if (state.userBooks.isEmpty) {
          //         return Column(
          //           children: [
          //             Container(
          //               padding: const EdgeInsets.symmetric(horizontal: 16),
          //               width: double.infinity,
          //               child: const Text(
          //                 "principal_screen.reading",
          //                 style: TextStyle(
          //                   fontSize: 22,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ).tr(),
          //             ),
          //             const SizedBox(height: 16),
          //             SizedBox(
          //               width: double.infinity,
          //               child: Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 16),
          //                 child: FAlert(
          //                   icon: FAssets.icons.badgeInfo(),
          //                   title:
          //                       const Text("principal_screen.no_reading_books")
          //                           .tr(),
          //                   subtitle:
          //                       const Text("principal_screen.no_to_read_books")
          //                           .tr(),
          //                   style: FAlertStyle.primary,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       }
          //       final List<UserBook> readingBooks = state.userBooks
          //           .where(
          //               (userBook) => userBook.status == UserBookStatus.reading)
          //           .toList();
          //       final List<UserBook> toReadBooks = state.userBooks
          //           .where(
          //               (userBook) => userBook.status == UserBookStatus.notRead)
          //           .toList();

          //       if (readingBooks.isEmpty && toReadBooks.isEmpty) {
          //         return Column(
          //           children: [
          //             Container(
          //               padding: const EdgeInsets.symmetric(horizontal: 16),
          //               width: double.infinity,
          //               child: const Text(
          //                 "principal_screen.reading",
          //                 style: TextStyle(
          //                   fontSize: 22,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ).tr(),
          //             ),
          //             const SizedBox(height: 16),
          //             SizedBox(
          //               width: double.infinity,
          //               child: Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 16),
          //                 child: FAlert(
          //                   icon: FAssets.icons.badgeInfo(),
          //                   title:
          //                       const Text("principal_screen.no_reading_books")
          //                           .tr(),
          //                   subtitle:
          //                       const Text("principal_screen.no_to_read_books")
          //                           .tr(),
          //                   style: FAlertStyle.primary,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       }

          //       return Column(
          //         children: [
          //           if (readingBooks.isNotEmpty)
          //             Column(
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.symmetric(horizontal: 16),
          //                   width: double.infinity,
          //                   child: const Text(
          //                     "principal_screen.reading",
          //                     style: TextStyle(
          //                       fontSize: 22,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                   ).tr(),
          //                 ),
          //                 const SizedBox(height: 12),
          //                 SizedBox(
          //                   width: double.infinity,
          //                   height: 200,
          //                   child: ListView.separated(
          //                     scrollDirection: Axis.horizontal,
          //                     shrinkWrap: true,
          //                     itemCount: readingBooks.length,
          //                     itemBuilder: (context, index) {
          //                       return MediumBookCard(
          //                         userBook: readingBooks[index],
          //                       );
          //                     },
          //                     padding:
          //                         const EdgeInsets.only(left: 16, right: 16),
          //                     separatorBuilder: (context, index) {
          //                       return const SizedBox(width: 12);
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           if (toReadBooks.isNotEmpty && readingBooks.isNotEmpty)
          //             const Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 16),
          //               child: FDivider(),
          //             ),
          //           if (toReadBooks.isNotEmpty)
          //             Column(
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.symmetric(horizontal: 16),
          //                   width: double.infinity,
          //                   child: const Text(
          //                     "principal_screen.to_read",
          //                     style: TextStyle(
          //                       fontSize: 22,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                   ).tr(),
          //                 ),
          //                 const SizedBox(height: 12),
          //                 SizedBox(
          //                   width: double.infinity,
          //                   height: 200,
          //                   child: ListView.separated(
          //                     scrollDirection: Axis.horizontal,
          //                     shrinkWrap: true,
          //                     itemCount: toReadBooks.length,
          //                     itemBuilder: (context, index) {
          //                       return MediumBookCard(
          //                         userBook: toReadBooks[index],
          //                       );
          //                     },
          //                     padding: const EdgeInsets.only(
          //                       left: 16,
          //                       right: 16,
          //                     ),
          //                     separatorBuilder: (context, index) {
          //                       return const SizedBox(width: 12);
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //         ],
          //       );
          //     }
          //     return const SizedBox.shrink();
          //   },
          // ),
        ],
      ),
    );
  }
}
