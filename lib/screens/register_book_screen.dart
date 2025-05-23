import 'package:anaquel/logic/books_bloc.dart';
import 'package:anaquel/screens/create_book_screen.dart';
import 'package:anaquel/widgets/books/register_small_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class RegisterBookScreen extends StatelessWidget {
  const RegisterBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BooksBloc, BooksState>(
      listener: (context, state) {},
      child: FScaffold(
        header: FHeader.nested(
          title: const Text("register_book_screen.title").tr(),
          prefixActions: [
            FHeaderAction.back(
              onPress: () => context.pop(),
            ),
          ],
        ),
        contentPad: false,
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FButton(
                onPress: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CreateBookScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                ),
                style: FButtonStyle.outline,
                label: const Text("register_book_screen.create").tr(),
              ),
              const FDivider(),
              FTextField(
                enabled: false,
                hint: "register_book_screen.search".tr(),
                maxLines: 1,
                suffix: Container(
                  padding: const EdgeInsets.all(12),
                  child: FAssets.icons.search(),
                ),
                onChange: (value) {
                  context.read<BooksBloc>().add(SearchBooks(value));
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<BooksBloc, BooksState>(
                builder: (context, state) {
                  if (state is BooksLoading) {
                    return const LinearProgressIndicator();
                  }
                  if (state is BooksError) {
                    return FAlert(
                      icon: FAssets.icons.badgeAlert(),
                      title:
                          const Text("register_book_screen.search_error").tr(),
                      subtitle: Text(state.message),
                      style: FAlertStyle.destructive,
                    );
                  }
                  if (state is BooksLoaded) {
                    return SizedBox(
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: state.books.length,
                        itemBuilder: (context, index) {
                          return RegisterSmallBookCard(
                            id: state.books[index].id,
                            image: state.books[index].coverUrl,
                            title: state.books[index].title,
                            author: state.books[index].authors.join(", "),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
