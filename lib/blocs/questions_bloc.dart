import 'package:anaquel/data/models/question.dart';
import 'package:anaquel/data/services/questions_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class QuestionsEvent {}

class GenerateQuestions extends QuestionsEvent {
  final String bookTitle;
  final String bookAuthor;

  GenerateQuestions({
    required this.bookTitle,
    required this.bookAuthor,
  });
}

abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;

  QuestionsLoaded(this.questions);
}

class QuestionsError extends QuestionsState {
  final String message;

  QuestionsError(this.message);
}

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionsService questionsService;

  QuestionsBloc(this.questionsService) : super(QuestionsInitial()) {
    on<GenerateQuestions>((event, emit) async {
      emit(QuestionsLoading());
      try {
        final questions = await questionsService.generateQuestions(
          event.bookTitle,
          event.bookAuthor,
        );
        emit(QuestionsLoaded(questions));
      } catch (e) {
        emit(QuestionsError(e.toString()));
      }
    });
  }
}
