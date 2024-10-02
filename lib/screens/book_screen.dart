import 'package:anaquel/widgets/chip.dart';
import 'package:anaquel/widgets/mini_tab.dart';
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
    return FTheme(
      data: FThemes.zinc.light,
      child: FScaffold(
        header: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: FHeader.nested(
            title: Text(lookId),
            // title: const SizedBox.shrink(),
            leftActions: [
              FHeaderAction.back(
                onPress: () => context.pop(),
              ),
            ],
            rightActions: [
              FHeaderAction(
                icon: FAssets.icons.ellipsisVertical,
                onPress: () {},
              ),
            ],
          ),
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
                    child: Image.network(
                      _image,
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
                  color: Color(0xFF232323),
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
                onPress: () {},
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
                  color: Color(0xFF232323),
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
      ),
    );
  }
}