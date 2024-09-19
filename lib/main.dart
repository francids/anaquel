import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Anaquel",
        builder: (context, child) => FTheme(
          data: FThemes.zinc.light,
          child: child!,
        ),
        home: const FScaffold(
          header: FHeader(
            title: Text(
              'Anaquel',
              style: TextStyle(
                color: Color(0xFF941932),
              ),
            ),
          ),
          contentPad: false,
          content: Center(
            child: Text('Hello, World!'),
          ),
        ),
      );
}
