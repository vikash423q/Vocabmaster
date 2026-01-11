part of 'daily_review_bloc.dart';

abstract class DailyReviewEvent extends Equatable {
  const DailyReviewEvent();

  @override
  List<Object> get props => [];
}

class LoadDailyStack extends DailyReviewEvent {}

class LoadMCQQuestion extends DailyReviewEvent {
  final int wordId;
  final int level;

  const LoadMCQQuestion(this.wordId, this.level);

  @override
  List<Object> get props => [wordId, level];
}

class SubmitMCQAnswer extends DailyReviewEvent {
  final int wordId;
  final String selectedWord;
  final String correctWord;
  final bool isCorrect;
  final int level;

  const SubmitMCQAnswer({
    required this.wordId,
    required this.selectedWord,
    required this.correctWord,
    required this.isCorrect,
    required this.level,
  });

  @override
  List<Object> get props => [wordId, selectedWord, correctWord, isCorrect, level];
}
