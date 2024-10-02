import 'package:anaquel/widgets/books/large_book_card.dart';
import 'package:flutter/material.dart';
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
  const CollectionScreen({super.key, required this.collection_id});

  final String collection_id;

  @override
  Widget build(BuildContext context) {
    final String collection = GoRouterState.of(context).extra! as String;
    return FTheme(
      data: FThemes.zinc.light,
      child: FScaffold(
        header: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: FHeader.nested(
            title: Text("$collection_id - $collection"),
            leftActions: [
              FHeaderAction.back(
                onPress: () => context.pop(),
              ),
            ],
          ),
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
      ),
    );
  }
}
