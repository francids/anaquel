import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

final List<String> _genres = [
  "Fiction",
  "Contemporary",
  "Romance",
  "Humor",
  "Adult",
];

class RegisterBookDetailsScreen extends StatelessWidget {
  const RegisterBookDetailsScreen({super.key});

  final String _image =
      "https://images.squarespace-cdn.com/content/v1/624da83e75ca872f189ffa42/aa45e942-f55d-432d-8217-17c7d98105ce/image001.jpg";
  final String _title = "really good, actually";
  final String _author = "Monica Heisey";
  final String _description =
      "A hilarious and painfully relatable debut novel about one woman’s messy search for joy and meaning in the wake of an unexpected breakup, from comedian, essayist, and award-winning screenwriter Monica Heisey";

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Registrando libro"),
        leftActions: [
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
            const SizedBox(height: 8),
            SizedBox(
              height: 260,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 0.625,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: FAssets.icons.circleX(),
                    ),
                    imageUrl: _image,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 240,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _author,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
              ),
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
            Text(
              _description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.eerieBlack,
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
                  for (final genre in _genres) AChip(label: genre),
                ],
              ),
            ),
            const FDivider(),
            FButton(
              onPress: () => context.pop(),
              style: FButtonStyle.primary,
              label: const Text("Registrar lectura"),
            ),
          ],
        ),
      ),
    );
  }
}
