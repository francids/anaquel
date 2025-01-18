import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ReadingTimeChip extends StatelessWidget {
  const ReadingTimeChip(this.time, {super.key});

  final String time;

  @override
  Widget build(BuildContext context) {
    return FBadge(
      style: FBadgeStyle.outline,
      label: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(time),
      ),
    );
  }
}
