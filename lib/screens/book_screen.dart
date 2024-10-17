import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/screens/recommendations_books_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:anaquel/widgets/mini_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

final List<String> _genres = [
  "Fiction",
  "Contemporary",
  "Romance",
  "Humor",
  "Adult",
];

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.lookId});

  final String lookId;
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
        title: Text(lookId),
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
                      context.pop();
                    },
                    child: const Text(
                      "Limpiar historial",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      "Colecciones",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      "Eliminar libro",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
            const SizedBox(height: 16),
            const MiniTab(
              label: "Leyendo",
              isSelected: true,
            ),
            const FDivider(),
            FButton(
              onPress: () {},
              style: FButtonStyle.primary,
              label: const Text("Reanudar lectura"),
            ),
            const SizedBox(height: 8),
            FButton(
              onPress: () {},
              style: FButtonStyle.outline,
              label: const Text("Cuestionario"),
            ),
            const SizedBox(height: 8),
            FButton(
              onPress: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const RecommendationsBooksScreen(),
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
              style: FButtonStyle.outline,
              label: const Text("Recomendaciones"),
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
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Historial",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
