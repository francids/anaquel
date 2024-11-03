import 'package:anaquel/data/models/book.dart';
import 'package:anaquel/data/services/books_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BooksEvent {}

class SearchBooks extends BooksEvent {
  final String title;

  SearchBooks(this.title);
}

class GetBook extends BooksEvent {
  final int id;

  GetBook(this.id);
}

abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final List<Book> books;

  BooksLoaded(this.books);
}

class BooksError extends BooksState {
  final String message;

  BooksError(this.message);
}

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksService booksService;

  BooksBloc(this.booksService) : super(BooksInitial()) {
    on<SearchBooks>((event, emit) async {
      emit(BooksLoading());
      try {
        final books = await booksService.searchBooks(event.title);
        emit(BooksLoaded(books));
      } catch (e) {
        emit(BooksError(e.toString()));
      }
    });

    on<GetBook>((event, emit) async {
      emit(BooksLoading());
      try {
        final book = await booksService.getBook(event.id);
        emit(BooksLoaded([book]));
      } catch (e) {
        emit(BooksError(e.toString()));
      }
    });
  }
}
