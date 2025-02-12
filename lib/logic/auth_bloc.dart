import 'package:anaquel/data/models/login_response.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/data/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final User user;

  LoginEvent(this.user);
}

class LogoutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final User user;

  SignUpEvent(this.user);
}

class EditUserEvent extends AuthEvent {
  final User user;

  EditUserEvent(this.user);
}

class ChangePasswordEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent(this.oldPassword, this.newPassword);
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponse loginResponse;

  AuthSuccess(this.loginResponse);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      bool alreadyTry = false;
      try {
        final exists = await authService.usernameExists(event.user.username);
        if (!exists) {
          emit(AuthFailure(
            "auth_screens.log_in_screen.error.invalid_user",
          ));
          return;
        }
        alreadyTry = true;
        final authResponse = await authService.login(event.user);
        emit(AuthSuccess(authResponse));
      } catch (e) {
        if (alreadyTry) {
          emit(AuthFailure(
            "auth_screens.log_in_screen.error.invalid_password",
          ));
          return;
        }
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await authService.logout();

      emit(AuthInitial());
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Sign up
        await authService.signUp(event.user);
        emit(AuthInitial());

        // Login after sign up
        await Future.delayed(const Duration(seconds: 1));
        final authResponse = await authService.login(event.user);
        emit(AuthSuccess(authResponse));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<EditUserEvent>((event, emit) async {
      emit(AuthLoading());
      final cookie = await authService.getCookie();
      try {
        await authService.editUser(event.user);
        emit(AuthInitial());
      } catch (e) {
        emit(AuthSuccess(LoginResponse(cookie: cookie!)));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final cookie = await authService.getCookie();
      try {
        await authService.changePassword(
          event.oldPassword,
          event.newPassword,
        );
        emit(AuthInitial());
      } catch (e) {
        emit(AuthSuccess(LoginResponse(cookie: cookie!)));
      }
    });
  }
}
