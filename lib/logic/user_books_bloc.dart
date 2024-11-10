import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/data/services/user_books_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserBooksEvent {}

class GetUserBooks extends UserBooksEvent {}

abstract class UserBooksState {}

class UserBooksInitial extends UserBooksState {}

class UserBooksLoading extends UserBooksState {}

class UserBooksLoaded extends UserBooksState {
  final List<UserBook> userBooks;

  UserBooksLoaded(this.userBooks);
}

class UserBooksError extends UserBooksState {
  final String message;

  UserBooksError(this.message);
}

class UserBooksBloc extends Bloc<UserBooksEvent, UserBooksState> {
  final UserBooksService userBooksService;

  UserBooksBloc(this.userBooksService) : super(UserBooksInitial()) {
    on<GetUserBooks>((event, emit) async {
      emit(UserBooksLoading());
      try {
        final userBooks = await userBooksService.getUserBooks();
        emit(UserBooksLoaded(userBooks));
      } catch (e) {
        emit(UserBooksError(e.toString()));
      }
    });
  }
}