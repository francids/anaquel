import 'package:anaquel/logic/collections_bloc.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/screens/all_books_screen.dart';
import 'package:anaquel/screens/all_local_books_screen.dart';
import 'package:anaquel/screens/register_book_screen.dart';
import 'package:anaquel/widgets/books/local_small_book_card.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:anaquel/widgets/collection_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> _collectionsColors = [
  "#005799",
  "#009926",
  "#99006b",
  "#A64200",
];

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: const Text(
              "books_screen.collections",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ).tr(),
          ),
          const SizedBox(height: 16),
          // BlocBuilder<CollectionsBloc, CollectionsState>(
          //   builder: (context, state) {
          //     if (state is CollectionsLoading) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     if (state is CollectionsError) {
          //       return FAlert(
          //         icon: FAssets.icons.badgeX(),
          //         title:
          //             const Text("books_screen.error_loading_collections").tr(),
          //         subtitle: Text(state.message),
          //         style: FAlertStyle.destructive,
          //       );
          //     }
          //     if (state is CollectionsLoaded) {
          //       if (state.collections.isEmpty) {
          //         return FAlert(
          //           icon: FIcon(FAssets.icons.badgeInfo),
          //           title: const Text(
          //             "books_screen.no_collections",
          //           ).tr(),
          //           style: FAlertStyle.primary,
          //         );
          //       }
          //       return SizedBox(
          //         width: double.infinity,
          //         child: Wrap(
          //           spacing: 8,
          //           runSpacing: 8,
          //           children: List.generate(
          //             state.collections.length,
          //             (index) {
          //               return SizedBox(
          //                 width: MediaQuery.of(context).size.width / 2 - 24,
          //                 child: CollectionChip(
          //                   label: state.collections[index].name,
          //                   color: Color(
          //                     int.parse(
          //                           state.collections[index].color.substring(1),
          //                           radix: 16,
          //                         ) +
          //                         0xFF000000,
          //                   ),
          //                   onPress: () => context.push(
          //                       "/collection/${state.collections[index].id}"),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     }
          //     return const SizedBox.shrink();
          //   },
          // ),
          const SizedBox(height: 16),
          FButton(
            // onPress: () => buildCreateCollectionDialog(context),
            onPress: null,
            style: FButtonStyle.outline,
            label: const Text("books_screen.create_collection.title").tr(),
          ),
          const FDivider(),
          FButton(
            onPress: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const RegisterBookScreen(),
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
            label: const Text("books_screen.register_book").tr(),
          ),
          const SizedBox(height: 16),
          // SizedBox(
          //   width: double.infinity,
          //   child: const Text(
          //     "books_screen.books",
          //     style: TextStyle(
          //       fontSize: 22,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ).tr(),
          // ),
          // const SizedBox(height: 16),
          // BlocBuilder<UserBooksBloc, UserBooksState>(
          //   builder: (context, state) {
          //     if (state is UserBooksLoading) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     if (state is UserBooksError) {
          //       return FAlert(
          //         icon: FAssets.icons.badgeX(),
          //         title: const Text("books_screen.error_loading_books").tr(),
          //         subtitle: Text(state.message),
          //         style: FAlertStyle.destructive,
          //       );
          //     }
          //     if (state is UserBooksLoaded) {
          //       if (state.userBooks.isEmpty) {
          //         return FAlert(
          //           icon: FIcon(FAssets.icons.badgeInfo),
          //           title: const Text(
          //             "books_screen.no_books",
          //           ).tr(),
          //           style: FAlertStyle.primary,
          //         );
          //       }
          //       return Column(
          //         children: [
          //           SizedBox(
          //             width: double.infinity,
          //             child: ListView.separated(
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               padding: const EdgeInsets.all(0),
          //               separatorBuilder: (context, index) =>
          //                   const SizedBox(height: 8),
          //               itemCount: state.userBooks.length > 3
          //                   ? 3
          //                   : state.userBooks.length,
          //               itemBuilder: (context, index) {
          //                 return SmallBookCard(
          //                   userBook: state.userBooks[index],
          //                 );
          //               },
          //             ),
          //           ),
          //           const SizedBox(height: 16),
          //           if (state.userBooks.length > 3)
          //             FButton(
          //               onPress: () => Navigator.of(context).push(
          //                 PageRouteBuilder(
          //                   pageBuilder:
          //                       (context, animation, secondaryAnimation) =>
          //                           const AllBooksScreen(),
          //                   transitionsBuilder: (context, animation,
          //                       secondaryAnimation, child) {
          //                     return SlideTransition(
          //                       position: Tween<Offset>(
          //                         begin: const Offset(1, 0),
          //                         end: Offset.zero,
          //                       ).animate(animation),
          //                       child: child,
          //                     );
          //                   },
          //                 ),
          //               ),
          //               style: FButtonStyle.outline,
          //               label: const Text("all_books_screen.title").tr(),
          //             ),
          //         ],
          //       );
          //     }
          //     return const SizedBox.shrink();
          //   },
          // ),
          // const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          BlocBuilder<LocalBooksBloc, LocalBooksState>(
            builder: (context, state) {
              if (state is LocalBooksLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LocalBooksError) {
                return FAlert(
                  icon: FIcon(FAssets.icons.badgeX),
                  title: const Text(
                    "books_screen.error_loading_local_books",
                  ).tr(),
                  subtitle: Text(state.message),
                  style: FAlertStyle.destructive,
                );
              }
              if (state is LocalBooksLoaded) {
                if (state.localBooks.isEmpty) {
                  return FAlert(
                    icon: FIcon(FAssets.icons.badgeInfo),
                    title: const Text(
                      "books_screen.no_local_books",
                    ).tr(),
                    style: FAlertStyle.primary,
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: state.localBooks.length > 3
                            ? 3
                            : state.localBooks.length,
                        itemBuilder: (context, index) {
                          return LocalSmallBookCard(
                            localBook: state.localBooks[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state.localBooks.length > 3)
                      FButton(
                        onPress: () => Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AllLocalBooksScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                        label: const Text("all_local_books_screen.title").tr(),
                      ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildCreateCollectionDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    String colorSelected = "#005799";

    return showAdaptiveDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (context) => FDialog(
        title: const Text("books_screen.create_collection.title").tr(),
        direction: Axis.vertical,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FTextField(
                  controller: nameController,
                  label: const Text("books_screen.create_collection.name").tr(),
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "books_screen.create_collection.please_enter_a_name"
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    'books_screen.create_collection.color',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ).tr(),
                ),
                const SizedBox(height: 8),
                BlockPicker(
                  pickerColor: Color(
                    int.parse(
                      _collectionsColors[0].substring(1),
                      radix: 16,
                    ),
                  ),
                  onColorChanged: (color) {
                    colorSelected = "#${color.toHexString().substring(2)}";
                  },
                  availableColors: _collectionsColors
                      .map((e) => Color(
                            int.parse(e.substring(1), radix: 16),
                          ))
                      .toList(),
                  useInShowDialog: true,
                  itemBuilder: (color, isCurrentColor, changeColor) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: context.theme.style.borderRadius,
                        color: color,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.8),
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: changeColor,
                          borderRadius: context.theme.style.borderRadius,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: isCurrentColor ? 1 : 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FIcon(
                                FAssets.icons.check,
                                color: useWhiteForeground(color)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  layoutBuilder: (context, colors, child) {
                    return SizedBox(
                      width: context.theme.breakpoints.sm,
                      height: context.theme.style.iconStyle.size * 3.2,
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        children: [for (Color color in colors) child(color)],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <FButton>[
          FButton(
            onPress: () {
              if (!formKey.currentState!.validate()) {
                return;
              }
              context.read<CollectionsBloc>().add(
                    CreateCollection(
                      nameController.text,
                      colorSelected,
                    ),
                  );
              context.pop();
            },
            style: FButtonStyle.primary,
            label: const Text("books_screen.create_collection.title").tr(),
          ),
          FButton(
            onPress: () => context.pop(),
            style: FButtonStyle.outline,
            label: const Text("books_screen.create_collection.cancel").tr(),
          ),
        ],
      ),
    );
  }
}
