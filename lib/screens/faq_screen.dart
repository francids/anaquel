import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final int quantity = 3;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("faq_screen.title").tr(),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FAccordion(
              controller: FAccordionController(),
              items: List.generate(
                quantity,
                (index) => FAccordionItem(
                  title: Text("faq_screen.questions.$index.question").tr(),
                  child: Text("faq_screen.questions.$index.answer").tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
