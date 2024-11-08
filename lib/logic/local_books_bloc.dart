import 'package:anaquel/data/models/local_book.dart';
import 'package:anaquel/data/services/local_books_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LocalBooksEvent {}

class LoadLocalBooks extends LocalBooksEvent {}

class AddLocalBook extends LocalBooksEvent {
  final LocalBook localBook;

  AddLocalBook({
    required this.localBook,
  });
}

abstract class LocalBooksState {}

class LocalBooksInitial extends LocalBooksState {}

class LocalBooksLoading extends LocalBooksState {}

class LocalBooksLoaded extends LocalBooksState {
  final List<LocalBook> localBooks;

  LocalBooksLoaded(this.localBooks);
}

class LocalBooksError extends LocalBooksState {
  final String message;

  LocalBooksError(this.message);
}

class LocalBooksBloc extends Bloc<LocalBooksEvent, LocalBooksState> {
  final LocalBooksService localBooksService;

  LocalBooksBloc(this.localBooksService) : super(LocalBooksInitial()) {
    on<LoadLocalBooks>((event, emit) async {
      emit(LocalBooksLoading());
      try {
        final localBooks = await localBooksService.getBooks();
        emit(LocalBooksLoaded(localBooks));
      } catch (e) {
        emit(LocalBooksError(e.toString()));
      }
    });

    on<AddLocalBook>((event, emit) async {
      emit(LocalBooksLoading());
      try {
        await localBooksService.addBook(event.localBook);
        final localBooks = await localBooksService.getBooks();
        emit(LocalBooksLoaded(localBooks));
      } catch (e) {
        emit(LocalBooksError(e.toString()));
      }
    });
  }
}
