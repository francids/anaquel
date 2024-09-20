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
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FTheme(
          data: FThemes.red.light,
          child: child!,
        );
      },
      home: FScaffold(
        header: FHeader(
          title: const Text(
            'Anaquel',
            textAlign: TextAlign.center,
          ),
          style: FRootHeaderStyle(
            titleTextStyle: const TextStyle(
              fontSize: 24,
              color: Color(0xFF941932),
              fontWeight: FontWeight.w900,
            ),
            actionSpacing: 16,
            actionStyle: FHeaderActionStyle(
              disabledColor: const Color(0xFF050505),
              enabledColor: const Color(0xFF050505),
              size: 22,
            ),
            padding: const EdgeInsets.only(),
          ),
        ),
        contentPad: false,
        content: const Center(
          child: Text('Hello, World!'),
        ),
        footer: FBottomNavigationBar(
          style: FBottomNavigationBarStyle(
            item: FBottomNavigationBarItemStyle(
              activeIconColor: const Color(0xFF050505),
              activeTextStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF050505),
              ),
              inactiveIconColor: const Color(0xFF232323),
              inactiveTextStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF232323),
              ),
              iconSize: 22,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
              ),
            ),
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.overlay,
              color: const Color(0xFFFBFBFB),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -1),
                ),
              ],
            ),
          ),
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
