import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> saveHasSeenGetStarted() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("has_seen_get_started", true);
    }

    void goToLogin() {
      saveHasSeenGetStarted().then((_) => context.push("/login"));
    }

    return IntroductionScreen(
      key: GlobalKey<IntroductionScreenState>(),
      allowImplicitScrolling: true,
      globalBackgroundColor: AppColors.burgundy,
      globalHeader: const SizedBox(height: 16),
      globalFooter: const SizedBox(height: 16),
      dotsDecorator: const DotsDecorator(
        color: AppColors.puce,
        activeColor: AppColors.antiFlashWhite,
        size: Size(8, 8),
        activeSize: Size(16, 8),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        spacing: EdgeInsets.all(4),
      ),
      initialPage: 0,
      resizeToAvoidBottomInset: true,
      pages: [
        PageViewModel(
          title: "Bienvenido a Anaquel",
          body:
              "Una aplicación que te permite gestionar su lectura de manera fácil y concisa.",
          image: Image.asset("assets/get_started/logo.png"),
          decoration: const PageDecoration(
            imageAlignment: Alignment.bottomCenter,
            bodyAlignment: Alignment.topCenter,
            imagePadding: EdgeInsets.zero,
            bodyPadding: EdgeInsets.symmetric(horizontal: 16),
            titlePadding: EdgeInsets.only(top: 32, bottom: 8),
            titleTextStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.antiFlashWhite,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.antiFlashWhite,
            ),
          ),
        ),
        PageViewModel(
          title: "Un asistente para ti",
          body:
              "Anaquel te permite gestionar tus libros, agruparlos en colecciones, planificar tus horarios de lectura y generar cuestionarios.",
          image: Image.asset("assets/get_started/illustration.png"),
          decoration: const PageDecoration(
            imageAlignment: Alignment.bottomCenter,
            bodyAlignment: Alignment.topCenter,
            imagePadding: EdgeInsets.zero,
            bodyPadding: EdgeInsets.symmetric(horizontal: 16),
            titlePadding: EdgeInsets.only(top: 32, bottom: 8),
            titleTextStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.antiFlashWhite,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.antiFlashWhite,
            ),
          ),
        ),
      ],
      showBackButton: false,
      showNextButton: true,
      showSkipButton: true,
      showDoneButton: true,
      onDone: () => goToLogin(),
      onSkip: () => goToLogin(),
      next: const Text("Siguiente"),
      skip: const Text("Saltar"),
      done: const Text("Iniciar"),
      baseBtnStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.antiFlashWhite),
      ),
      controlsMargin: const EdgeInsets.all(16),
    );
  }
}
