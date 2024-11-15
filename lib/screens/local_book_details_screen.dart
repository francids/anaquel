import 'dart:io';

import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/local_book.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/screens/edit_book_screen.dart';
import 'package:anaquel/screens/reading_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class LocalBookDetailsScreen extends StatefulWidget {
  const LocalBookDetailsScreen({super.key, required this.localBook});

  final LocalBook localBook;

  @override
  State<LocalBookDetailsScreen> createState() => _LocalBookDetailsScreenState();
}

class _LocalBookDetailsScreenState extends State<LocalBookDetailsScreen>
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

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Libro local"),
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
                    prefixIcon: FIcon(FAssets.icons.pencil),
                    title: const Text("Editar libro"),
                    onPress: () => Navigator.of(context)
                        .push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EditBookScreen(localBook: widget.localBook),
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
                    )
                        .whenComplete(
                      () {
                        context.pop();
                        context.pop();
                      },
                    ),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.trash),
                    title: const Text("Eliminar libro"),
                    onPress: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) => FDialog(
                        direction: Axis.vertical,
                        body: const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            "¿Estás seguro de que deseas eliminar este libro?",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        actions: <FButton>[
                          FButton(
                            onPress: () {
                              final File imageFile =
                                  File(widget.localBook.coverUrl);
                              imageFile.exists().then(
                                (exists) {
                                  (exists) ? imageFile.delete() : null;
                                },
                              );
                              context.read<LocalBooksBloc>().add(
                                    RemoveLocalBook(
                                        localBook: widget.localBook),
                                  );
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
                    ),
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
                  child: Image.file(
                    File(widget.localBook.coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.localBook.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.localBook.author,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
              ),
            ),
            const SizedBox(height: 16),
            const AChip(label: "Leyendo"),
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
                widget.localBook.description,
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
                  for (final genre in widget.localBook.genres)
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
