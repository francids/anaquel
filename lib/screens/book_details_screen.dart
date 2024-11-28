import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/logic/collections_bloc.dart';
import 'package:anaquel/logic/summary_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/screens/questionnaire_screen.dart';
import 'package:anaquel/screens/reading_screen.dart';
import 'package:anaquel/screens/recommendations_books_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.userBook});

  final UserBook userBook;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with SingleTickerProviderStateMixin {
  late FPopoverController popoverController;

  @override
  initState() {
    popoverController = FPopoverController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  String convertStatus(UserBookStatus status) {
    switch (status) {
      case UserBookStatus.reading:
        return "Leyendo";
      case UserBookStatus.read:
        return "Leído";
      case UserBookStatus.notRead:
        return "No leído";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Detalles del libro"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        suffixActions: [
          FPopoverMenu.tappable(
            controller: popoverController,
            menuAnchor: Alignment.topRight,
            childAnchor: Alignment.bottomRight,
            ignoreDirectionalPadding: true,
            hideOnTapOutside: true,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.trash),
                    title: const Text("Borrar libro"),
                    onPress: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) => FDialog(
                          direction: Axis.vertical,
                          body: const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              "¿Estás seguro de que deseas eliminar este libro? Esto eliminará el libro de tus colecciones y no podrás recuperarlo.",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          actions: <FButton>[
                            FButton(
                              onPress: () {
                                context
                                    .read<UserBooksBloc>()
                                    .add(RemoveUserBook(
                                      widget.userBook.id.toString(),
                                    ));
                                context
                                    .read<CollectionsBloc>()
                                    .add(GetCollections());
                                context.pop();
                                context.pop();
                              },
                              style: FButtonStyle.destructive,
                              label: const Text("Eliminar"),
                            ),
                            FButton(
                              onPress: () => context.pop(),
                              style: FButtonStyle.outline,
                              label: const Text("Cancelar"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.library),
                    title: const Text("Colecciones"),
                    onPress: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return BlocBuilder<CollectionsBloc, CollectionsState>(
                            builder: (context, state) {
                              if (state is CollectionsLoaded) {
                                if (state.collections.isEmpty) {
                                  return FDialog(
                                    title: const Text("Colecciones"),
                                    body: const Text("No tienes colecciones"),
                                    actions: [
                                      FButton(
                                        onPress: () => context.pop(),
                                        style: FButtonStyle.outline,
                                        label: const Text("Cancelar"),
                                      ),
                                    ],
                                  );
                                }

                                var originalValues = {
                                  for (final collection in state.collections)
                                    for (final book in collection.books)
                                      if (book.id == widget.userBook.id)
                                        collection.id,
                                };

                                FMultiSelectGroupController<int> controller =
                                    FMultiSelectGroupController(
                                  values: {
                                    for (final value in originalValues) value,
                                  },
                                );
                                return FDialog(
                                  title: const Text("Colecciones"),
                                  body: FSelectTileGroup<int>(
                                    controller: controller,
                                    children:
                                        state.collections.map((collection) {
                                      return FSelectTile(
                                        title: Text(collection.name),
                                        value: collection.id,
                                        suffixIcon: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(
                                              int.parse(
                                                "0xFF${collection.color.replaceAll("#", "")}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  actions: [
                                    FButton(
                                      onPress: () {
                                        final selectedCollections =
                                            controller.values;
                                        // Adding books
                                        for (final collectionId
                                            in selectedCollections) {
                                          if (!originalValues
                                              .contains(collectionId)) {
                                            context.read<CollectionsBloc>().add(
                                                  AddBookToCollection(
                                                    collectionId.toString(),
                                                    widget.userBook.id
                                                        .toString(),
                                                  ),
                                                );
                                          }
                                        }
                                        // Removing books
                                        for (final collectionId
                                            in originalValues) {
                                          if (!selectedCollections
                                              .contains(collectionId)) {
                                            context.read<CollectionsBloc>().add(
                                                  RemoveBookFromCollection(
                                                    collectionId.toString(),
                                                    widget.userBook.id
                                                        .toString(),
                                                  ),
                                                );
                                          }
                                        }
                                        context.pop();
                                      },
                                      style: FButtonStyle.primary,
                                      label: const Text("Guardar"),
                                    ),
                                    FButton(
                                      onPress: () => context.pop(),
                                      style: FButtonStyle.outline,
                                      label: const Text("Cancelar"),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          );
                        },
                      );
                    },
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.fileText),
                    title: const Text("Generar resumen"),
                    onPress: () {
                      context.read<SummaryBloc>().add(
                            GenerateSummary(
                              bookTitle: widget.userBook.title,
                              bookAuthor: widget.userBook.authors.join(", "),
                            ),
                          );
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return BlocBuilder<SummaryBloc, SummaryState>(
                            builder: (context, state) {
                              return FDialog(
                                title: const Text("Resumen"),
                                body: state is SummaryLoaded
                                    ? Text(
                                        state.summary,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: AppColors.eerieBlack,
                                        ),
                                      )
                                    : state is SummaryError
                                        ? Text(state.message)
                                        : const CircularProgressIndicator(),
                                actions: [
                                  FButton(
                                    onPress: () => context.pop(),
                                    style: FButtonStyle.outline,
                                    label: const Text("Cerrar"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
            child: FIcon(FAssets.icons.ellipsisVertical),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                    imageUrl: widget.userBook.coverUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 240,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.userBook.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.userBook.authors.join(", "),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
              ),
            ),
            const SizedBox(height: 16),
            FBadge(
              label: Text(convertStatus(widget.userBook.status)),
              style: FBadgeStyle.secondary,
            ),
            const FDivider(),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ReadingScreen(),
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
              style: FButtonStyle.primary,
              label: const Text("Reanudar lectura"),
            ),
            const SizedBox(height: 8),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      QuestionnaireScreen(
                    bookId: widget.userBook.id,
                    bookTitle: widget.userBook.title,
                    bookAuthor: widget.userBook.authors.join(", "),
                  ),
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
              label: const Text("Cuestionario"),
            ),
            const SizedBox(height: 8),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const RecommendationsBooksScreen(),
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
              label: const Text("Recomendaciones"),
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
            Text(
              widget.userBook.description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
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
                  for (final genre in widget.userBook.genres)
                    AChip(label: genre),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
