import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';

part 'progress.freezed.dart';
part 'progress.g.dart';

@freezed
class DailyStackItem with _$DailyStackItem {
  const factory DailyStackItem({
    required int id,
    @JsonKey(name: 'word_id') required int wordId,
    required String word,
    @JsonKey(name: 'scheduled_date') required String scheduledDate,
    @JsonKey(name: 'is_reviewed') required bool isReviewed,
    @Default(0) int level, // Fibonacci level
  }) = _DailyStackItem;

  factory DailyStackItem.fromJson(Map<String, dynamic> json) =>
      _$DailyStackItemFromJson(json);
}

@freezed
class AddWordsRequest with _$AddWordsRequest {
  const factory AddWordsRequest({
    @JsonKey(name: 'word_ids') required List<int> wordIds,
  }) = _AddWordsRequest;

  factory AddWordsRequest.fromJson(Map<String, dynamic> json) =>
      _$AddWordsRequestFromJson(json);
}

@freezed
class AddWordsResponse with _$AddWordsResponse {
  const factory AddWordsResponse({
    required String message,
    @JsonKey(name: 'added_count') required int addedCount,
  }) = _AddWordsResponse;

  factory AddWordsResponse.fromJson(Map<String, dynamic> json) =>
      _$AddWordsResponseFromJson(json);
}

@freezed
class ReviewSubmit with _$ReviewSubmit {
  const factory ReviewSubmit({
    @JsonKey(name: 'word_id') required int wordId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    @JsonKey(name: 'question_type') required String questionType,
    @JsonKey(name: 'user_answer') String? userAnswer,
    @JsonKey(name: 'correct_answer') required String correctAnswer,
    @JsonKey(name: 'time_taken_seconds') int? timeTakenSeconds,
    @JsonKey(name: 'options_presented') List<String>? optionsPresented,
  }) = _ReviewSubmit;

  factory ReviewSubmit.fromJson(Map<String, dynamic> json) =>
      _$ReviewSubmitFromJson(json);
}

@freezed
class ReviewResponse with _$ReviewResponse {
  const factory ReviewResponse({
    required bool success,
    @JsonKey(name: 'new_level') required int newLevel,
    @JsonKey(name: 'next_review_date') String? nextReviewDate,
    required String status,
    required String message,
  }) = _ReviewResponse;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
}

@freezed
class WordProgressDetail with _$WordProgressDetail {
  const factory WordProgressDetail({
    @JsonKey(name: 'word_id') required int wordId,
    String? word,
    @JsonKey(name: 'fibonacci_level') required int fibonacciLevel,
    @JsonKey(name: 'next_review_date') String? nextReviewDate,
    @JsonKey(name: 'correct_count') required int correctCount,
    @JsonKey(name: 'incorrect_count') required int incorrectCount,
    @JsonKey(name: 'last_reviewed_at') String? lastReviewedAt,
    required String status,
    @JsonKey(name: 'added_at') String? addedAt,
    @JsonKey(name: 'mastered_at') String? masteredAt,
  }) = _WordProgressDetail;

  factory WordProgressDetail.fromJson(Map<String, dynamic> json) =>
      _$WordProgressDetailFromJson(json);
}

@freezed
class UpcomingReview with _$UpcomingReview {
  const factory UpcomingReview({
    @JsonKey(name: 'word_id') required int wordId,
    String? word,
    @JsonKey(name: 'review_date') String? reviewDate,
    required int level,
  }) = _UpcomingReview;

  factory UpcomingReview.fromJson(Map<String, dynamic> json) =>
      _$UpcomingReviewFromJson(json);
}

@freezed
class ProgressWord with _$ProgressWord {
  const factory ProgressWord({
    required int id,
    String? word,
    String? pronunciation,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'difficulty_level') @Default(5.0) double difficultyLevel,
    @JsonKey(name: 'importance_score') @Default(50) int importanceScore,
    required String status,
    @JsonKey(name: 'fibonacci_level') required int fibonacciLevel,
    @JsonKey(name: 'next_review_date') String? nextReviewDate,
    @JsonKey(name: 'correct_count') @Default(0) int correctCount,
    @JsonKey(name: 'incorrect_count') @Default(0) int incorrectCount,
    @JsonKey(name: 'last_reviewed_at') String? lastReviewedAt,
    @JsonKey(name: 'added_at') String? addedAt,
    @JsonKey(name: 'mastered_at') String? masteredAt,
    String? tone,
    @JsonKey(name: 'cefr_level') String? cefrLevel,
  }) = _ProgressWord;

  factory ProgressWord.fromJson(Map<String, dynamic> json) =>
      _$ProgressWordFromJson(json);
}

@freezed
class ProgressWordsResponse with _$ProgressWordsResponse {
  const factory ProgressWordsResponse({
    required List<ProgressWord> words,
    required int total,
    required String status,
  }) = _ProgressWordsResponse;

  factory ProgressWordsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgressWordsResponseFromJson(json);
}

@freezed
class MCQQuestion with _$MCQQuestion {
  const factory MCQQuestion({
    @JsonKey(name: 'word_id') required int wordId,
    required String word,
    required String definition,
    required List<String> options,
    @JsonKey(name: 'correct_answer') required String correctAnswer,
    required int level,
  }) = _MCQQuestion;

  factory MCQQuestion.fromJson(Map<String, dynamic> json) =>
      _$MCQQuestionFromJson(json);
}

@freezed
class DailyStackQuestion with _$DailyStackQuestion {
  const factory DailyStackQuestion({
    required int id,
    @JsonKey(name: 'word_id') required int wordId,
    @JsonKey(name: 'scheduled_date') required String scheduledDate,
    @JsonKey(name: 'is_reviewed') required bool isReviewed,
    required int level,
    required MCQQuestion question,
    @JsonKey(name: 'word_detail') required WordDetail wordDetail,
  }) = _DailyStackQuestion;

  factory DailyStackQuestion.fromJson(Map<String, dynamic> json) {
    return DailyStackQuestion(
      id: json['id'] as int,
      wordId: json['word_id'] as int,
      scheduledDate: json['scheduled_date'] as String,
      isReviewed: json['is_reviewed'] as bool,
      level: json['level'] as int,
      question: MCQQuestion.fromJson(json['question'] as Map<String, dynamic>),
      wordDetail: WordDetail.fromJson(json['word_detail'] as Map<String, dynamic>),
    );
  }
}
