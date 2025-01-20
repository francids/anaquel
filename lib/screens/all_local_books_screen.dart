import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/widgets/books/local_small_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class AllLocalBooksScreen extends StatelessWidget {
  const AllLocalBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("all_local_books_screen.title").tr(),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: BlocBuilder<LocalBooksBloc, LocalBooksState>(
        builder: (context, state) {
          if (state is LocalBooksLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: state.localBooks.length,
              itemBuilder: (context, index) {
                return LocalSmallBookCard(
                  localBook: state.localBooks[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
