import 'package:anaquel/data/services/summary_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SummaryEvent {}

class GenerateSummary extends SummaryEvent {
  final String bookTitle;
  final String bookAuthor;

  GenerateSummary({
    required this.bookTitle,
    required this.bookAuthor,
  });
}

abstract class SummaryState {}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummaryLoaded extends SummaryState {
  final String summary;

  SummaryLoaded(this.summary);
}

class SummaryError extends SummaryState {
  final String message;

  SummaryError(this.message);
}

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final SummaryService summaryService;

  SummaryBloc(this.summaryService) : super(SummaryInitial()) {
    on<GenerateSummary>((event, emit) async {
      emit(SummaryLoading());
      try {
        final summary = await summaryService.generateSummary(
          event.bookTitle,
          event.bookAuthor,
        );
        emit(SummaryLoaded(summary));
      } catch (e) {
        emit(SummaryError(e.toString()));
      }
    });
  }
}
