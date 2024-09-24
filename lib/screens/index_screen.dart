import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

// Screens
import 'package:anaquel/screens/books_screen.dart';
import 'package:anaquel/screens/principal_screen.dart';
import 'package:anaquel/screens/profile_screen.dart';
import 'package:anaquel/screens/schedules_screen.dart';

List<String> _titles = [
  'Anaquel',
  'Libros',
  'Horarios de lectura',
  'Perfil',
];

List<Widget> _screens = [
  const PrincipalScreen(),
  const BooksScreen(),
  const SchedulesScreen(),
  const ProfileScreen(),
];

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return FScaffold(
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
        child: FHeader(
          title: Text(_titles[index]),
          key: ValueKey(index),
          style: FRootHeaderStyle(
            titleTextStyle: TextStyle(
              fontSize: 24,
              color: index == 0
                  ? const Color(0xFF941932)
                  : const Color(0xFF050505),
              fontWeight: index == 0 ? FontWeight.w800 : FontWeight.w600,
            ),
            actionSpacing: 16,
            actionStyle: FHeaderActionStyle(
              disabledColor: const Color(0xFF050505),
              enabledColor: const Color(0xFF050505),
              size: 22,
            ),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 16,
            ),
          ),
        ),
      ),
      contentPad: false,
      content: _screens[index],
      footer: FBottomNavigationBar(
        style: FBottomNavigationBarStyle(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
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
              bottom: 8,
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
    );
  }
}
