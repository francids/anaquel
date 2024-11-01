import 'package:anaquel/blocs/user_books_bloc.dart';
import 'package:anaquel/screens/register/register_book_screen.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:anaquel/widgets/collection_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> _collections = [
  "Colección 01",
  "Colección 02",
  "Colección 03",
  "Colección 04",
];

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
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Colecciones",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                _collections.length,
                (index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: CollectionChip(
                      label: _collections[index],
                      color: Color(
                        int.parse(
                              _collectionsColors[index].substring(1),
                              radix: 16,
                            ) +
                            0xFF000000,
                      ),
                      onPress: () => context.push(
                        "/collection/$index",
                        extra: _collections[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          FButton(
            onPress: () => buildCreateCollectionDialog(context),
            style: FButtonStyle.outline,
            label: const Text("Crear colección"),
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
            label: const Text("Registrar libro"),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Libros",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<UserBooksBloc, UserBooksState>(
            builder: (context, state) {
              if (state is UserBooksLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserBooksError) {
                return FAlert(
                  icon: FAlertIcon(icon: FAssets.icons.badgeX),
                  title: const Text("Error al cargar libros"),
                  subtitle: Text(state.message),
                  style: FAlertStyle.destructive,
                );
              }
              if (state is UserBooksLoaded) {
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
                        itemCount: state.books.length,
                        itemBuilder: (context, index) {
                          return SmallBookCard(
                            id: state.books[index].id,
                            image: state.books[index].coverUrl,
                            title: state.books[index].title,
                            author: state.books[index].authors.join(", "),
                          );
                        },
                      ),
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
    return showAdaptiveDialog(
      context: context,
      builder: (context) => FDialog(
        title: const Text("Crear colección"),
        direction: Axis.vertical,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              const Text(
                "Ingresa el nombre y decide el color:",
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              const FTextField(
                label: Text('Nombre:'),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Color:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              BlockPicker(
                pickerColor: Colors.red,
                onColorChanged: (color) {},
                availableColors: _collectionsColors
                    .map((e) => Color(
                          int.parse(e.substring(1), radix: 16),
                        ))
                    .toList(),
                useInShowDialog: true,
                layoutBuilder: (context, colors, child) {
                  return Column(
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 6,
                        children: List.generate(
                          colors.length,
                          (index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors[index].withOpacity(1),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: child(colors[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        actions: <FButton>[
          FButton(
            onPress: () => context.pop(),
            style: FButtonStyle.primary,
            label: const Text("Crear colección"),
          ),
          FButton(
            onPress: () => context.pop(),
            style: FButtonStyle.outline,
            label: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}
