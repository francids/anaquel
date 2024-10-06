import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

// Screens
import 'package:anaquel/screens/home/books_screen.dart';
import 'package:anaquel/screens/home/principal_screen.dart';
import 'package:anaquel/screens/home/profile_screen.dart';
import 'package:anaquel/screens/home/schedules_screen.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
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
              color: index == 0 ? AppColors.burgundy : AppColors.black,
              fontWeight: index == 0 ? FontWeight.w800 : FontWeight.w600,
            ),
            actionSpacing: 16,
            actionStyle: FHeaderActionStyle(
              disabledColor: AppColors.black,
              enabledColor: AppColors.black,
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
            activeIconColor: AppColors.black,
            activeTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.black,
            ),
            inactiveIconColor: AppColors.eerieBlack,
            inactiveTextStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.eerieBlack,
            ),
            iconSize: 22,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
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
