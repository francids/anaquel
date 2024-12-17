import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/logic/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({
    super.key,
    required this.verificationCode,
    required this.user,
  });

  final String verificationCode;
  final User user;

  final TextEditingController codeController = TextEditingController();

  void sendCode(BuildContext context) {
    if (codeController.text == verificationCode) {
      context.read<AuthBloc>().add(SignUpEvent(user));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.burgundy;
    const fillColor = AppColors.white;
    const borderColor = AppColors.eerieBlack;

    final pinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: AppColors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Material(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/');
          }
        },
        child: FScaffold(
          header: Column(
            children: [
              FHeader.nested(
                title: const Text(
                  "auth_screens.verification_code_screen.title",
                ).tr(),
                prefixActions: [
                  FHeaderAction.back(
                    onPress: () => context.pop(),
                  ),
                ],
                suffixActions: [
                  FHeaderAction(
                    icon: FAssets.icons.languages(),
                    onPress: () {
                      context.setLocale(
                        context.locale == const Locale("en")
                            ? const Locale("es")
                            : const Locale("en"),
                      );
                    },
                  ),
                ],
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const LinearProgressIndicator();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          contentPad: false,
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    "auth_screens.verification_code_screen.message",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.eerieBlack,
                    ),
                  ).tr(),
                ),
                const SizedBox(height: 16),
                Pinput(
                  length: 6,
                  controller: codeController,
                  defaultPinTheme: pinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    if (value == verificationCode) {
                      return null;
                    } else {
                      return "auth_screens.verification_code_screen.error_code"
                          .tr();
                    }
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (value) {
                    sendCode(context);
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: pinTheme.copyWith(
                    decoration: pinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: pinTheme.copyWith(
                    decoration: pinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: pinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
