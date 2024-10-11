import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'package:anaquel/screens/home/home_screen.dart';
import 'package:anaquel/screens/auth/auth_screen.dart';
import 'package:anaquel/screens/auth/change_password_screen.dart';
import 'package:anaquel/screens/auth/edit_profile_screen.dart';
import 'package:anaquel/screens/book_screen.dart';
import 'package:anaquel/screens/collection_screen.dart';
import 'package:anaquel/screens/register_book_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const Application());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/auth",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const AuthScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/change-password",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ChangePasswordScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/collection/:collection_id",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: CollectionScreen(
            collection_id: state.pathParameters['collection_id']!,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/book/:book_id",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: BookScreen(
            lookId: state.pathParameters['book_id']!,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/register_book",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterBookScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/edit_profile",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Anaquel",
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      builder: (context, child) {
        return FTheme(
          data: FThemes.zinc.light,
          child: child!,
        );
      },
      routerConfig: _router,
    );
  }
}
