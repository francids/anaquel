import 'package:anaquel/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'package:anaquel/screens/auth/log_in_screen.dart';
import 'package:anaquel/screens/home/home_screen.dart';
import 'package:anaquel/screens/collection_screen.dart';
import 'package:anaquel/screens/book_details_screen.dart';
import 'package:anaquel/screens/register/register_book_details_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final authService = AuthService();
    final token = await authService.getToken();
    final tokenType = await authService.getTokenType();
    return (token == null || tokenType == null) ? '/login' : null;
  },
  routes: [
    GoRoute(
      path: "/login",
      redirect: (context, state) async {
        final authService = AuthService();
        final token = await authService.getToken();
        final tokenType = await authService.getTokenType();
        return (token == null || tokenType == null) ? null : '/';
      },
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: LogInScreen(),
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
          child: BookDetailsScreen(
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
