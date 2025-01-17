import 'package:anaquel/logic/questions_bloc.dart';
import 'package:anaquel/utils/url.dart';
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
  void initState() {
    context.read<QuestionsBloc>().add(GetQuestions(widget.bookId));
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
            popoverController: popoverController,
            menuAnchor: Alignment.topRight,
            childAnchor: Alignment.bottomRight,
            directionPadding: false,
            hideOnTapOutside: true,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.alignLeft),
                    title: const Text("questionnaire_screen.generate").tr(),
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
                    title: const Text("utils.links").tr(),
                    prefixIcon: FIcon(FAssets.icons.link),
                    onPress: () {
                      launchUrlSafely(
                        Uri.parse(
                          "https://anaquel.me/docs/functions/exams",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: const Text(
                "questionnaire_screen.title",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
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
                    title: const Text("questionnaire_screen.error").tr(),
                    subtitle: Text(state.message),
                    style: FAlertStyle.destructive,
                  );
                }
                if (state is QuestionsLoaded) {
                  if (state.questions.isEmpty) {
                    return FAlert(
                      icon: FAssets.icons.badgeInfo(),
                      title:
                          const Text("questionnaire_screen.no_questions").tr(),
                      style: FAlertStyle.primary,
                    );
                  }
                  return Column(
                    children: [
                      Column(
                        children: state.questions.map((question) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: FTextField(
                              label: Text(question.question),
                              initialValue: question.answer,
                              onChange: (value) {
                                question.answer = value;
                              },
                              minLines: 3,
                              hint: "questionnaire_screen.placeholder".tr(),
                            ),
                          );
                        }).toList(),
                      ),
                      if (state.questions.isNotEmpty)
                        FButton(
                          label: const Text("questionnaire_screen.save").tr(),
                          onPress: () {
                            context.read<QuestionsBloc>().add(
                                  SaveQuestions(
                                    widget.bookId,
                                    state.questions,
                                  ),
                                );
                          },
                        ),
                      const SizedBox(height: 24),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
