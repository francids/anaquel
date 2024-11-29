import 'dart:io';

import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/local_book.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/screens/edit_book_screen.dart';
import 'package:anaquel/screens/reading_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:easy_localization/easy_localization.dart';
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

  int status = 0;

  @override
  initState() {
    popoverController = FPopoverController(vsync: this);
    status = widget.localBook.status;
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
        title: const Text("local_books_screens.details.title").tr(),
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
                    title: const Text("local_books_screens.details.menu.edit")
                        .tr(),
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
                    title: const Text("local_books_screens.details.menu.remove")
                        .tr(),
                    onPress: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) => FDialog(
                        direction: Axis.vertical,
                        body: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: const Text(
                            "local_books_screens.details.menu.remove_body",
                            textAlign: TextAlign.start,
                          ).tr(),
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
                            label: const Text(
                                    "local_books_screens.details.menu.remove")
                                .tr(),
                          ),
                          FButton(
                            onPress: () => context.pop(),
                            style: FButtonStyle.outline,
                            label: const Text(
                                    "local_books_screens.details.menu.cancel")
                                .tr(),
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
            GestureDetector(
              onTap: () {
                buildUpdateStatusDialog(context).then((value) {
                  if (value != null) {
                    setState(() => status = value);
                  }
                });
              },
              child: FBadge(
                label: Text(
                  status == 0
                      ? "local_books_screens.details.status.not_read".tr()
                      : status == 1
                          ? "local_books_screens.details.status.reading".tr()
                          : "local_books_screens.details.status.read".tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.eerieBlack,
                  ),
                ),
                style: FBadgeStyle.secondary,
              ),
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
              label:
                  const Text("local_books_screens.details.resume_reading").tr(),
            ),
            const FDivider(),
            SizedBox(
              width: double.infinity,
              child: const Text(
                "local_books_screens.details.description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
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
            SizedBox(
              width: double.infinity,
              child: const Text(
                "local_books_screens.details.genres",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
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

  Future<dynamic> buildUpdateStatusDialog(BuildContext context) {
    FRadioSelectGroupController<int> controller =
        FRadioSelectGroupController<int>(value: status);
    return showAdaptiveDialog(
      context: context,
      builder: (context) => FDialog(
        direction: Axis.vertical,
        title:
            const Text("local_books_screens.details.status.update_status").tr(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: FSelectTileGroup<int>(
            controller: controller,
            children: [
              FSelectTile(
                title: const Text("local_books_screens.details.status.not_read")
                    .tr(),
                value: 0,
              ),
              FSelectTile(
                title: const Text("local_books_screens.details.status.reading")
                    .tr(),
                value: 1,
              ),
              FSelectTile(
                title:
                    const Text("local_books_screens.details.status.read").tr(),
                value: 2,
              ),
            ],
          ),
        ),
        actions: <FButton>[
          FButton(
            onPress: () {
              context.read<LocalBooksBloc>().add(
                    UpdateLocalBook(
                      localBook: widget.localBook.copyWith(
                        status: controller.values.first,
                      ),
                    ),
                  );
              context.pop(controller.values.first);
            },
            style: FButtonStyle.primary,
            label: const Text("local_books_screens.details.status.save").tr(),
          ),
          FButton(
            onPress: () => context.pop(),
            style: FButtonStyle.outline,
            label: const Text("local_books_screens.details.status.cancel").tr(),
          ),
        ],
      ),
    );
  }
}
