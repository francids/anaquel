import 'package:flutter_bloc/flutter_bloc.dart';

// Blocs
import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/logic/books_bloc.dart';
import 'package:anaquel/logic/user_bloc.dart';
import 'package:anaquel/logic/user_books_bloc.dart';
import 'package:anaquel/logic/collections_bloc.dart';
import 'package:anaquel/logic/questions_bloc.dart';
import 'package:anaquel/logic/local_books_bloc.dart';
import 'package:anaquel/logic/summary_bloc.dart';
import 'package:anaquel/logic/schedules_bloc.dart';

// Services
import 'package:anaquel/data/services/auth_service.dart';
import 'package:anaquel/data/services/books_service.dart';
import 'package:anaquel/data/services/user_service.dart';
import 'package:anaquel/data/services/user_books_service.dart';
import 'package:anaquel/data/services/collections_service.dart';
import 'package:anaquel/data/services/questions_service.dart';
import 'package:anaquel/data/services/local_books_service.dart';
import 'package:anaquel/data/services/summary_service.dart';
import 'package:anaquel/data/services/schedules_service.dart';

class Providers {
  static blocs() {
    return [
      BlocProvider(
        create: (_) => AuthBloc(AuthService()),
      ),
      BlocProvider(
        create: (_) => BooksBloc(BooksService()),
      ),
      BlocProvider(
        create: (_) => UserBloc(UserService()),
      ),
      BlocProvider(
        create: (_) => UserBooksBloc(UserBooksService()),
      ),
      BlocProvider(
        create: (_) => CollectionsBloc(CollectionsService()),
      ),
      BlocProvider(
        create: (_) => QuestionsBloc(QuestionsService()),
      ),
      BlocProvider(
        create: (_) => LocalBooksBloc(LocalBooksService()),
      ),
      BlocProvider(
        create: (_) => SummaryBloc(SummaryService()),
      ),
      BlocProvider(
        create: (_) => SchedulesBloc(SchedulesService()),
      ),
    ];
  }
}
