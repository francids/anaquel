import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/local_small_book_card.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ReadingTimeScreen extends StatelessWidget {
  const ReadingTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var calendarController = FCalendarController.date(
      initialSelection: DateTime.now(),
      selectable: (value) => value.isBefore(DateTime.now()),
    );
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
          FLineCalendar(
            builder: (context, data, child) => child!,
            controller: calendarController,
            start: DateTime.now().subtract(const Duration(days: 30)),
            end: DateTime.now(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const FDivider(),
                SizedBox(
                  width: double.infinity,
                  child: FCard.raw(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text("reading_time_screen.total_time").tr(),
                          const Text(
                            "1 hora 30 minutos",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              return SmallBookCard(
                                userBook: state.userBooks[index],
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
                              return LocalSmallBookCard(
                                localBook: state.localBooks[index],
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
