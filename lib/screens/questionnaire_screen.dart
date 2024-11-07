import 'package:anaquel/blocs/questions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class QuestionnaireScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(bookTitle),
        leftActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        rightActions: [
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
                      context.read<QuestionsBloc>().add(
                            GenerateQuestions(
                              bookTitle: bookTitle,
                              bookAuthor: bookAuthor,
                            ),
                          );
                      context.pop();
                    },
                    child: const Text(
                      "Generar cuestionario",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      "Guardar",
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
                    icon: FAlertIcon(icon: FAssets.icons.badgeX),
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
