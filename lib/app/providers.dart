import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Blocs
import 'package:anaquel/blocs/auth_bloc.dart';
import 'package:anaquel/blocs/books_bloc.dart';

// Services
import 'package:anaquel/data/services/auth_service.dart';
import 'package:anaquel/data/services/books_service.dart';

List<BlocProvider> blocProviders(BuildContext context) {
  return [
    BlocProvider(create: (context) => AuthBloc(AuthService())),
    BlocProvider(create: (context) => BooksBloc(BooksService())),
  ];
}
