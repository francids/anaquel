import 'package:anaquel/logic/collections_bloc.dart';
import 'package:anaquel/widgets/books/large_book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> _bookCovers = [
  "https://marketplace.canva.com/EAFutLMZJKs/1/0/1003w/canva-portada-libro-novela-suspenso-elegante-negro-wxuYB_sJtMw.jpg",
  "https://marketplace.canva.com/EAFjNCKkDPI/1/0/1003w/canva-portada-de-libro-de-fantas%C3%ADa-dram%C3%A1tico-verde-Ct1fLal3ekY.jpg",
  "https://edit.org/images/cat/portadas-libros-big-2019101610.jpg",
  "https://marketplace.canva.com/EAFI171fL0M/1/0/1003w/canva-portada-de-libro-de-novela-ilustrado-color-azul-aqua-PQeWaiiK0aA.jpg",
];

List<String> _bookTitles = [
  "Cruce de Caminos",
  "Reyes Caídos",
  "Mi Portada de Libro Mi Portada de Libro Mi Portada de Libro",
  "Hasta que el verano se acabe",
];

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key, required this.collectionId});

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text("$collectionId"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        suffixActions: [
          CustomPopup(
            content: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) => FDialog(
                          direction: Axis.vertical,
                          body: const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              "¿Estás seguro de que deseas eliminar esta colección?",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          actions: <FButton>[
                            FButton(
                              onPress: () => {
                                context.read<CollectionsBloc>().add(
                                      DeleteCollection(
                                        collectionId.toString(),
                                      ),
                                    ),
                                context.pop(),
                                context.pop(),
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
                    child: const Text(
                      "Eliminar colección",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FAssets.icons.ellipsisVertical(),
            ),
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
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 12,
                runSpacing: 24,
                children: List.generate(
                  _bookTitles.length,
                  (index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      child: LargeBookCard(
                        id: index.toString(),
                        image: _bookCovers[index],
                        title: _bookTitles[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
