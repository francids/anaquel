import 'package:anaquel/logic/books_bloc.dart';
import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class RegisterBookDetailsScreen extends StatelessWidget {
  RegisterBookDetailsScreen({super.key, required this.bookId});

  final int bookId;

  @override
  Widget build(BuildContext context) {
    context.read<BooksBloc>().add(GetBook(bookId));
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Registrando libro"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksLoading) {
            return const Column(
              children: [
                LinearProgressIndicator(),
              ],
            );
          } else if (state is BooksError) {
            return Column(
              children: [
                FAlert(
                  icon: FAssets.icons.badgeX(),
                  title: const Text("Error al cargar libro"),
                  subtitle: Text(state.message),
                  style: FAlertStyle.destructive,
                ),
              ],
            );
          } else if (state is BooksLoaded) {
            final book = state.books.first;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 260,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 0.625,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: FAssets.icons.circleX(),
                          ),
                          imageUrl: book.coverUrl,
                          fit: BoxFit.cover,
                          width: 150,
                          height: 240,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.authors.join(", "),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.eerieBlack,
                    ),
                  ),
                  const FDivider(),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Descripción",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      book.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.eerieBlack,
                      ),
                    ),
                  ),
                  const FDivider(),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Géneros",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final genre in book.genres) AChip(label: genre),
                      ],
                    ),
                  ),
                  const FDivider(),
                  FButton(
                    onPress: () {},
                    style: FButtonStyle.primary,
                    label: const Text("Registrar lectura"),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
