import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class AllBooksScreen extends StatelessWidget {
  const AllBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("all_books_screen.title").tr(),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: BlocBuilder<UserBooksBloc, UserBooksState>(
        builder: (context, state) {
          if (state is UserBooksLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: state.userBooks.length,
              itemBuilder: (context, index) {
                return SmallBookCard(
                  userBook: state.userBooks[index],
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
