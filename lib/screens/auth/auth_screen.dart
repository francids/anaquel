import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF941932),
      ),
    );
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return FTheme(
      data: FThemes.zinc.light,
      child: FScaffold(
        contentPad: true,
        style: FScaffoldStyle(
          contentPadding: const EdgeInsets.all(16),
          footerDecoration: const BoxDecoration(),
          headerDecoration: const BoxDecoration(),
          backgroundColor: const Color(0xFF941932),
        ),
        content: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: keyboardHeight),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icon/logotipo.svg",
                    height: 50,
                  ),
                  const SizedBox(height: 16),
                  FTabs(
                    tabs: <FTabEntry>[
                      FTabEntry(
                        label: const Text(
                          "Iniciar sesión",
                          style: TextStyle(fontSize: 15),
                        ),
                        content: FCard(
                          style: FCardStyle(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            content: const FCardContentStyle(
                              titleTextStyle: TextStyle(),
                              subtitleTextStyle: TextStyle(),
                              padding: EdgeInsets.all(24),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 6),
                              const FTextField(
                                  label: Text('Correo electrónico')),
                              const SizedBox(height: 16),
                              const FTextField(label: Text('Contraseña')),
                              const SizedBox(height: 16),
                              FButton(
                                onPress: () {
                                  context.go('/');
                                },
                                style: FButtonStyle.primary,
                                label: const Text("Iniciar sesión"),
                              ),
                              const SizedBox(height: 8),
                              const FDivider(vertical: false),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "O puedes iniciar sesión con:",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FButton(
                                prefix:
                                    SvgPicture.asset("assets/google_icon.svg"),
                                onPress: () {},
                                style: FButtonStyle.outline,
                                label: const Text("Continuar con Google"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FTabEntry(
                        label: const Text(
                          "Crear cuenta",
                          style: TextStyle(fontSize: 15),
                        ),
                        content: FCard(
                          style: FCardStyle(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            content: const FCardContentStyle(
                              titleTextStyle: TextStyle(),
                              subtitleTextStyle: TextStyle(),
                              padding: EdgeInsets.all(24),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 6),
                              const FTextField(label: Text('Nombre')),
                              const SizedBox(height: 16),
                              const FTextField(
                                  label: Text('Correo electrónico')),
                              const SizedBox(height: 16),
                              const FTextField(label: Text('Contraseña')),
                              const SizedBox(height: 16),
                              const FTextField(
                                  label: Text('Confirmar contraseña')),
                              const SizedBox(height: 16),
                              FButton(
                                onPress: () {
                                  context.go('/');
                                },
                                style: FButtonStyle.primary,
                                label: const Text("Crear cuenta"),
                              ),
                              const SizedBox(height: 8),
                              const FDivider(vertical: false),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "O puedes registrarte con:",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FButton(
                                prefix:
                                    SvgPicture.asset("assets/google_icon.svg"),
                                onPress: () {},
                                style: FButtonStyle.outline,
                                label: const Text("Registrarse con Google"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
