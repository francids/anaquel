import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class CreateBookScreen extends StatelessWidget {
  const CreateBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Creando libro"),
        leftActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 260,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 0.625,
                  child: Container(
                    color: AppColors.antiFlashWhite,
                    width: 150,
                    height: 240,
                    child: Center(
                      child: FAssets.icons.camera(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Título'),
              hint: "Título",
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Autor'),
              hint: "Autor",
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Descripción'),
              hint: "Descripción",
              minLines: 3,
              maxLines: 6,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Géneros'),
              hint: "Géneros",
              maxLines: 1,
            ),
            const FDivider(),
            FButton(
              onPress: () {},
              style: FButtonStyle.primary,
              label: const Text("Crear libro"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
