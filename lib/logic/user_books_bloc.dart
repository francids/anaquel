import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/data/services/user_books_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserBooksEvent {}

class GetUserBooks extends UserBooksEvent {}

class AddUserBook extends UserBooksEvent {
  final String bookId;

  AddUserBook(this.bookId);
}

class RemoveUserBook extends UserBooksEvent {
  final String bookId;

  RemoveUserBook(this.bookId);
}

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

    on<AddUserBook>((event, emit) async {
      try {
        await userBooksService.addUserBook(event.bookId);
        add(GetUserBooks());
      } catch (e) {
        emit(UserBooksError(e.toString()));
      }
    });

    on<RemoveUserBook>((event, emit) async {
      try {
        await userBooksService.removeUserBook(event.bookId);
        add(GetUserBooks());
      } catch (e) {
        emit(UserBooksError(e.toString()));
      }
    });
  }
}
