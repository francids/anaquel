import 'package:flutter_bloc/flutter_bloc.dart';

// Blocs
import 'package:anaquel/blocs/auth_bloc.dart';
import 'package:anaquel/blocs/books_bloc.dart';

// Services
import 'package:anaquel/data/services/auth_service.dart';
import 'package:anaquel/data/services/books_service.dart';

class Providers {
  static blocs() {
    return [
      BlocProvider(
        create: (_) => AuthBloc(AuthService()),
      ),
      BlocProvider(
        create: (_) => BooksBloc(BooksService()),
      )
    ];
  }
}