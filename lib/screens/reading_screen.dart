import 'dart:async';

import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/services/reading_service.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key, required this.bookId});

  final String bookId;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final ReadingService _readingService = ReadingService();
  late Timer _timer;
  int _seconds = 0;

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(() => _seconds++),
    );
  }

  void _saveTime() {
    _readingService.saveReadingTime(widget.bookId, _seconds);
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _saveTime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Leyendo"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.puce,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.puce.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _formatTime(_seconds),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const FDivider(),
              FButton(
                onPress: () {
                  context.pop();
                },
                style: FButtonStyle.outline,
                label: const Text("Salir"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
