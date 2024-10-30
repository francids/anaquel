import 'package:anaquel/data/models/book.dart';
import 'package:anaquel/data/services/books_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchBooks extends BooksEvent {
  final String title;

  SearchBooks(this.title);

  @override
  List<Object?> get props => [title];
}

abstract class BooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final List<Book> books;

  BooksLoaded(this.books);

  @override
  List<Object?> get props => [books];
}

class BooksError extends BooksState {
  final String message;

  BooksError(this.message);

  @override
  List<Object?> get props => [message];
}

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksService booksService;

  BooksBloc(this.booksService) : super(BooksInitial()) {
    on<SearchBooks>((event, emit) async {
      emit(BooksLoading());
      try {
        final books = await booksService.getBooks(event.title);
        emit(BooksLoaded(books));
      } catch (e) {
        emit(BooksError(e.toString()));
      }
    });
  }
}
