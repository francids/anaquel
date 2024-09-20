import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MaterialApp(
      title: "Anaquel",
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: FThemes.red.light,
          child: child!,
        );
      },
      home: FScaffold(
        header: const FHeader(
          title: Text(
            'Anaquel',
            style: TextStyle(
              color: Color(0xFF941932),
            ),
          ),
        ),
        contentPad: false,
        content: const Center(
          child: Text('Hello, World!'),
        ),
        footer: FBottomNavigationBar(
          index: index,
          onChange: (index) => setState(() => this.index = index),
          items: [
            FBottomNavigationBarItem(
              icon: FAssets.icons.home,
              label: 'Principal',
            ),
            FBottomNavigationBarItem(
              icon: FAssets.icons.book,
              label: "Libros",
            ),
            FBottomNavigationBarItem(
              icon: FAssets.icons.alarmClock,
              label: "Horarios",
            ),
            FBottomNavigationBarItem(
              icon: FAssets.icons.user,
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
