import 'package:anaquel/logic/questions_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({
    super.key,
    required this.bookId,
    required this.bookTitle,
    required this.bookAuthor,
  });

  final int bookId;
  final String bookTitle;
  final String bookAuthor;

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen>
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
        title: Text(widget.bookTitle),
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
                    prefixIcon: FIcon(FAssets.icons.alignLeft),
                    title: const Text("Generar cuestionario"),
                    onPress: () {
                      context.read<QuestionsBloc>().add(
                            GenerateQuestions(
                              bookTitle: widget.bookTitle,
                              bookAuthor: widget.bookAuthor,
                              language: context.locale.languageCode == "en"
                                  ? "english"
                                  : "español",
                            ),
                          );
                    },
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.save),
                    title: const Text("Guardar"),
                    onPress: () {},
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
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 8,
        ),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Cuestionario",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<QuestionsBloc, QuestionsState>(
              builder: (context, state) {
                if (state is QuestionsInitial) {
                  return const SizedBox(height: 0);
                }
                if (state is QuestionsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is QuestionsError) {
                  return FAlert(
                    icon: FAssets.icons.badgeX(),
                    title: const Text("Error al cargar el cuestionario"),
                    subtitle: Text(state.message),
                    style: FAlertStyle.destructive,
                  );
                }
                if (state is QuestionsLoaded) {
                  return Column(
                    children: state.questions.map((question) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: FTextField(
                          label: Text(question.question),
                          minLines: 3,
                          hint: "Escribe tu respuesta aquí",
                        ),
                      );
                    }).toList(),
                  );
                }
                return const SizedBox(height: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
