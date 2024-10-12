import 'package:anaquel/screens/register/register_book_screen.dart';
import 'package:anaquel/widgets/books/small_book_card.dart';
import 'package:anaquel/widgets/collection_chip.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> _collections = [
  "Colección 01",
  "Colección 02",
  "Colección 03",
  "Colección 04",
  "Colección 05",
];

List<String> _collectionsColors = [
  "#FF8707",
  "#FF5722",
  "#E91E63",
  "#9C27B0",
  "#3F51B5",
];

List<String> _bookCovers = [
  "https://marketplace.canva.com/EAFutLMZJKs/1/0/1003w/canva-portada-libro-novela-suspenso-elegante-negro-wxuYB_sJtMw.jpg",
  "https://marketplace.canva.com/EAFjNCKkDPI/1/0/1003w/canva-portada-de-libro-de-fantas%C3%ADa-dram%C3%A1tico-verde-Ct1fLal3ekY.jpg",
  "https://edit.org/images/cat/portadas-libros-big-2019101610.jpg",
  "https://marketplace.canva.com/EAFI171fL0M/1/0/1003w/canva-portada-de-libro-de-novela-ilustrado-color-azul-aqua-PQeWaiiK0aA.jpg",
];

List<String> _bookTitles = [
  "Cruce de Caminos",
  "Reyes Caídos",
  "Mi Portada de Libro",
  "Hasta que el verano se acabe",
];

List<String> _bookAuthors = [
  "Naira Gamboa",
  "Julián Alonoso",
  "Nombre del Autor",
  "Connor Hamilton",
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
            onPress: () {},
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
              "Libros en ninguna colección",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: _bookTitles.length,
              itemBuilder: (context, index) {
                return SmallBookCard(
                  id: index.toString(),
                  image: _bookCovers[index],
                  title: _bookTitles[index],
                  author: _bookAuthors[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
