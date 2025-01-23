import 'package:anaquel/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<String> _anaquelGenres = [
  "Self Help",
  "Action",
  "Adventure",
  "Biography",
  "Classics",
  "Science Fiction",
  "True Crime",
  "Fantasy",
  "Horror",
  "Mystery",
  "Romance",
  "Theory",
  "Informational",
  "Spiritual",
  "Educational",
  "Gambling",
  "Dystopian",
  "Epic",
  "Historical Fiction",
  "Crime Fiction",
  "Speculative Fiction",
  "Humor",
  "Young Adult",
  "Medical/Forensic",
  "Military",
  "Nonfiction Narrative",
  "New Adult",
  "Police Procedural",
  "Post-Apocalyptic",
  "Psychological",
  "Magical Realism",
  "Satire",
  "Supernatural",
  "Suspense",
  "Thriller",
  "Urban",
  "Western",
  "Novel",
];

String convertGenreAnaquel(String original) {
  if (_anaquelGenres.contains(original)) {
    return "genres.$original"
        .toLowerCase()
        .replaceAll(" ", "_")
        .replaceAll("/", "_")
        .tr();
  }
  return original;
}

class AChip extends StatelessWidget {
  const AChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.antiFlashWhite,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        convertGenreAnaquel(label),
      ),
    );
  }
}
