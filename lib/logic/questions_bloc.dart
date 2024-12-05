import 'package:anaquel/data/models/question.dart';
import 'package:anaquel/data/services/questions_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class QuestionsEvent {}

class GenerateQuestions extends QuestionsEvent {
  final String bookTitle;
  final String bookAuthor;
  final String language;

  GenerateQuestions({
    required this.bookTitle,
    required this.bookAuthor,
    required this.language,
  });
}

class GetQuestions extends QuestionsEvent {
  final int bookId;

  GetQuestions(this.bookId);
}

class SaveQuestions extends QuestionsEvent {
  final int bookId;
  final List<Question> questions;

  SaveQuestions(this.bookId, this.questions);
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
          event.language,
        );
        emit(QuestionsLoaded(questions));
      } catch (e) {
        emit(QuestionsError(e.toString()));
      }
    });

    on<GetQuestions>((event, emit) async {
      emit(QuestionsLoading());
      try {
        final questions = await questionsService.getQuestions(event.bookId);
        emit(QuestionsLoaded(questions));
      } catch (e) {
        emit(QuestionsError(e.toString()));
      }
    });

    on<SaveQuestions>((event, emit) async {
      emit(QuestionsLoading());
      try {
        final questions = await questionsService.saveQuestionsWithAnswers(
          event.bookId,
          event.questions,
        );
        emit(QuestionsLoaded(questions));
      } catch (e) {
        emit(QuestionsError(e.toString()));
      }
    });
  }
}
