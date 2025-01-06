import 'package:anaquel/data/models/collection.dart';
import 'package:anaquel/logic/collections_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/widgets/books/large_book_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key, required this.collectionId});

  final int collectionId;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  late FPopoverController popoverController;
  String collectionName = "Colección";
  String collectionColor = "#000000";

  updateScreenHeader(String title, String color) {
    setState(() {
      collectionName = title;
      collectionColor = color;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Stack(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(
                    int.parse(
                      "0xFF${collectionColor.replaceAll("#", "")}",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  collectionName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        suffixActions: [
          FPopoverMenu.tappable(
            popoverController: popoverController,
            menuAnchor: Alignment.topRight,
            childAnchor: Alignment.bottomRight,
            directionPadding: false,
            hideOnTapOutside: true,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.trash),
                    title: const Text(
                            "collection_screen.menu.delete_collection.title")
                        .tr(),
                    onPress: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) => FDialog(
                          direction: Axis.vertical,
                          body: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: const Text(
                              "collection_screen.menu.delete_collection.message",
                              textAlign: TextAlign.start,
                            ).tr(),
                          ),
                          actions: <FButton>[
                            FButton(
                              onPress: () => {
                                context.read<CollectionsBloc>().add(
                                      DeleteCollection(
                                        widget.collectionId.toString(),
                                      ),
                                    ),
                                context.pop(),
                                context.pop(),
                              },
                              style: FButtonStyle.destructive,
                              label: const Text(
                                      "collection_screen.menu.delete_collection.delete")
                                  .tr(),
                            ),
                            FButton(
                              onPress: () => context.pop(),
                              style: FButtonStyle.outline,
                              label: const Text(
                                      "collection_screen.menu.delete_collection.cancel")
                                  .tr(),
                            ),
                          ],
                        ),
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
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 48,
        ),
        child: BlocBuilder<CollectionsBloc, CollectionsState>(
          builder: (context, state) {
            if (state is CollectionsError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is CollectionsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CollectionsLoaded) {
              var collection = state.collections.firstWhere(
                (collection) => collection.id == widget.collectionId,
                orElse: () => Collection(
                  id: 0,
                  name: "Colección",
                  color: "#000000",
                  books: [],
                ),
              );
              SchedulerBinding.instance.addPostFrameCallback((_) {
                updateScreenHeader(
                  collection.name,
                  collection.color,
                );
              });
              if (collection.books.isEmpty) {
                return Center(
                  child: const Text("collection_screen.no_books").tr(),
                );
              }
              return BlocBuilder<UserBooksBloc, UserBooksState>(
                builder: (context, userBookState) {
                  if (userBookState is UserBooksLoaded) {
                    var booksCollection = collection.books
                        .map(
                          (book) => userBookState.userBooks.firstWhere(
                            (userBook) => userBook.id == book.id,
                          ),
                        )
                        .toList();
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 24,
                            children: List.generate(
                              collection.books.length,
                              (index) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      32,
                                  child: LargeBookCard(
                                    key: ValueKey(
                                      collection.books[index].id,
                                    ),
                                    userBook: booksCollection[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
