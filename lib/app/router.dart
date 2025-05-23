// import 'package:anaquel/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'package:anaquel/screens/get_started_screen.dart';
// import 'package:anaquel/screens/auth/log_in_screen.dart';
import 'package:anaquel/screens/home/home_screen.dart';
import 'package:anaquel/screens/collection_screen.dart';
import 'package:anaquel/screens/register_book_details_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/get_started',
  routes: [
    GoRoute(
      path: "/get_started",
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final bool hasSeenGetStarted =
            prefs.getBool("has_seen_get_started") ?? false;
        return hasSeenGetStarted ? "/" : null;
      },
      builder: (context, state) {
        return const GetStartedScreen();
      },
    ),
    // GoRoute(
    //   path: "/login",
    //   redirect: (context, state) async {
    //     final authService = AuthService();
    //     final cookie = await authService.getCookie();
    //     if (cookie != null) {
    //       return '/';
    //     }
    //     return null;
    //   },
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: LogInScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return SlideTransition(
    //           position: Tween<Offset>(
    //             begin: const Offset(0, 1),
    //             end: Offset.zero,
    //           ).animate(animation),
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
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
      path: "/collection/:collection_id",
      pageBuilder: (context, state) {
        final int collectionId =
            int.parse(state.pathParameters['collection_id']!);
        return CustomTransitionPage(
          key: state.pageKey,
          child: CollectionScreen(collectionId: collectionId),
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
      path: "/register_book/:book_id",
      pageBuilder: (context, state) {
        final int bookId = int.parse(state.pathParameters['book_id']!);
        return CustomTransitionPage(
          key: state.pageKey,
          child: RegisterBookDetailsScreen(bookId: bookId),
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
  ],
);
