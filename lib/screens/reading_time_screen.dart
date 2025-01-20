import 'package:anaquel/data/services/reading_service.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/local_small_book_card.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:anaquel/widgets/reading_time_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ReadingTimeScreen extends StatelessWidget {
  ReadingTimeScreen({super.key});

  final ReadingService readingService = ReadingService();

  String formatReadingTime(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    if (hours == 0) return "${minutes}m";
    return "${hours}h ${minutes}m";
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("reading_time_screen.title").tr(),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                FAlert(
                  title: const Text(
                    "reading_time_screen.info_title",
                  ).tr(),
                  subtitle: const Text(
                    "reading_time_screen.info_subtitle",
                  ).tr(),
                  icon: FIcon(FAssets.icons.badgeAlert),
                ),
                BlocBuilder<UserBooksBloc, UserBooksState>(
                  builder: (context, state) {
                    if (state is UserBooksLoaded) {
                      if (state.userBooks.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          const FDivider(),
                          SizedBox(
                            width: double.infinity,
                            child: const Text(
                              "books_screen.books",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ).tr(),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            itemCount: state.userBooks.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  SmallBookCard(
                                    userBook: state.userBooks[index],
                                  ),
                                  FutureBuilder(
                                    future: readingService
                                        .getTimeSpentReadingByBook(
                                      state.userBooks[index].id.toString(),
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Positioned(
                                          top: 0,
                                          right: 12,
                                          bottom: 0,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: ReadingTimeChip(
                                              formatReadingTime(
                                                snapshot.data as int,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 12);
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                BlocBuilder<LocalBooksBloc, LocalBooksState>(
                  builder: (context, state) {
                    if (state is LocalBooksLoaded) {
                      if (state.localBooks.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          const FDivider(),
                          SizedBox(
                            width: double.infinity,
                            child: const Text(
                              "books_screen.local_books",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ).tr(),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            itemCount: state.localBooks.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  LocalSmallBookCard(
                                    localBook: state.localBooks[index],
                                  ),
                                  FutureBuilder(
                                    future: readingService
                                        .getTimeSpentReadingByBook(
                                      state.localBooks[index].id,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Positioned(
                                          top: 0,
                                          right: 12,
                                          bottom: 0,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: ReadingTimeChip(
                                              formatReadingTime(
                                                snapshot.data as int,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 12);
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
