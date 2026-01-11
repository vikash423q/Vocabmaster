part of 'daily_review_bloc.dart';

abstract class DailyReviewState extends Equatable {
  const DailyReviewState();

  @override
  List<Object> get props => [];
}

class DailyReviewInitial extends DailyReviewState {}

class DailyReviewLoading extends DailyReviewState {}

class DailyReviewLoaded extends DailyReviewState {
  final List<DailyStackQuestion> items;

  const DailyReviewLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class MCQQuestionLoading extends DailyReviewState {}

class MCQQuestionLoaded extends DailyReviewState {
  final int wordId;
  final String word;
  final String definition;
  final List<String> options; // 4 options including correct answer
  final String correctAnswer;
  final int level;

  const MCQQuestionLoaded({
    required this.wordId,
    required this.word,
    required this.definition,
    required this.options,
    required this.correctAnswer,
    required this.level,
  });

  @override
  List<Object> get props => [wordId, word, definition, options, correctAnswer, level];
}

class MCQAnswerRevealed extends DailyReviewState {
  final int wordId;
  final String selectedWord;
  final String correctAnswer;
  final bool isCorrect;
  final int newLevel;
  final WordDetail? wordDetail; // Word details to show below card

  const MCQAnswerRevealed({
    required this.wordId,
    required this.selectedWord,
    required this.correctAnswer,
    required this.isCorrect,
    required this.newLevel,
    this.wordDetail,
  });

  @override
  List<Object> get props => [wordId, selectedWord, correctAnswer, isCorrect, newLevel, wordDetail ?? wordId]; // Use wordId as fallback for null wordDetail
}

class DailyReviewError extends DailyReviewState {
  final String message;

  const DailyReviewError(this.message);

  @override
  List<Object> get props => [message];
}
