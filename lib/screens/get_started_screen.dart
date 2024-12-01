import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  Future<void> saveHasSeenGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("has_seen_get_started", true);
  }

  void goToLogin() async {
    await saveHasSeenGetStarted();
    if (mounted) {
      context.go("/login");
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: GlobalKey<IntroductionScreenState>(),
      allowImplicitScrolling: true,
      globalBackgroundColor: AppColors.burgundy,
      globalHeader: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: FButton.icon(
              style: FButtonStyle.secondary,
              child: FIcon(
                FAssets.icons.languages,
                color: AppColors.burgundy,
              ),
              onPress: () {
                context.setLocale(
                  context.locale == const Locale('en')
                      ? const Locale('es')
                      : const Locale('en'),
                );
              },
            ),
          ),
        ],
      ),
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
          title: "get_started.0.title".tr(),
          body: "get_started.0.body".tr(),
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
          title: "get_started.1.title".tr(),
          body: "get_started.1.body".tr(),
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
      onDone: goToLogin,
      onSkip: goToLogin,
      next: const Text("get_started.next").tr(),
      skip: const Text("get_started.skip").tr(),
      done: const Text("get_started.done").tr(),
      baseBtnStyle: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.antiFlashWhite,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      controlsMargin: const EdgeInsets.all(16),
    );
  }
}
