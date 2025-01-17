import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/utils/url.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

// Blocs
import 'package:anaquel/logic/user_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/logic/collections_bloc.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/logic/schedules_bloc.dart';

// Screens
import 'package:anaquel/screens/home/books_screen.dart';
import 'package:anaquel/screens/home/principal_screen.dart';
import 'package:anaquel/screens/home/profile_screen.dart';
import 'package:anaquel/screens/home/schedules_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Locale? currentLocale;

  void goToBooks() => setState(() => index = 1);

  void _refreshState() {
    setState(() {
      currentLocale = context.locale;
    });
  }

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    context.read<UserBloc>().add(GetUser());
    context.read<UserBooksBloc>().add(GetUserBooks());
    context.read<CollectionsBloc>().add(GetCollections());
    context.read<LocalBooksBloc>().add(LoadLocalBooks());
    context.read<SchedulesBloc>().add(GetSchedules());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocale = context.locale;
    _screens = [
      PrincipalScreen(onShowAllBooks: goToBooks),
      const BooksScreen(),
      const SchedulesScreen(),
      ProfileScreen(onLanguageChanged: _refreshState),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text(
          [
            "Anaquel",
            "books".tr(),
            "reading_schedules".tr(),
            "profile".tr(),
          ][index],
        ),
        actions: (index == 2)
            ? [
                FHeaderAction(
                  icon: FAssets.icons.link(),
                  onPress: () {
                    launchUrlSafely(
                      Uri.parse(
                        "https://anaquel.me/docs/functions/schedules",
                      ),
                    );
                  },
                ),
              ]
            : [],
        key: ValueKey("$index-${context.locale}"),
        style: FRootHeaderStyle(
          titleTextStyle: TextStyle(
            fontSize: 24,
            color: index == 0
                ? (Theme.of(context).brightness == Brightness.light
                    ? AppColors.burgundy
                    : AppColors.white)
                : null,
            fontWeight: index == 0 ? FontWeight.w800 : FontWeight.w600,
          ),
          actionSpacing: 16,
          actionStyle: FHeaderActionStyle(
            focusedOutlineStyle: FFocusedOutlineStyle(
              color: AppColors.burgundy,
              borderRadius: BorderRadius.circular(8),
            ),
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
      contentPad: false,
      content: _screens[index],
      footer: FBottomNavigationBar(
        index: index,
        onChange: (index) => setState(() => this.index = index),
        children: [
          FBottomNavigationBarItem(
            icon: FAssets.icons.house(),
            label: Text("principal".tr()),
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.book(),
            label: Text("books".tr()),
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.alarmClock(),
            label: Text("schedules".tr()),
          ),
          FBottomNavigationBarItem(
            icon: FAssets.icons.user(),
            label: Text("profile".tr()),
          ),
        ],
      ),
    );
  }
}
