import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress.freezed.dart';
part 'progress.g.dart';

@freezed
class DailyStackItem with _$DailyStackItem {
  const factory DailyStackItem({
    required int id,
    required int wordId,
    required String word,
    required String scheduledDate,
    required bool isReviewed,
  }) = _DailyStackItem;

  factory DailyStackItem.fromJson(Map<String, dynamic> json) =>
      _$DailyStackItemFromJson(json);
}

@freezed
class AddWordsRequest with _$AddWordsRequest {
  const factory AddWordsRequest({
    required List<int> wordIds,
  }) = _AddWordsRequest;

  factory AddWordsRequest.fromJson(Map<String, dynamic> json) =>
      _$AddWordsRequestFromJson(json);
}

@freezed
class AddWordsResponse with _$AddWordsResponse {
  const factory AddWordsResponse({
    required String message,
    required int addedCount,
  }) = _AddWordsResponse;

  factory AddWordsResponse.fromJson(Map<String, dynamic> json) =>
      _$AddWordsResponseFromJson(json);
}

@freezed
class ReviewSubmit with _$ReviewSubmit {
  const factory ReviewSubmit({
    required int wordId,
    required bool isCorrect,
    required String questionType,
    String? userAnswer,
    required String correctAnswer,
    int? timeTakenSeconds,
    List<String>? optionsPresented,
  }) = _ReviewSubmit;

  factory ReviewSubmit.fromJson(Map<String, dynamic> json) =>
      _$ReviewSubmitFromJson(json);
}

@freezed
class ReviewResponse with _$ReviewResponse {
  const factory ReviewResponse({
    required bool success,
    required int newLevel,
    String? nextReviewDate,
    required String status,
    required String message,
  }) = _ReviewResponse;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
}

@freezed
class WordProgressDetail with _$WordProgressDetail {
  const factory WordProgressDetail({
    required int wordId,
    String? word,
    required int fibonacciLevel,
    String? nextReviewDate,
    required int correctCount,
    required int incorrectCount,
    String? lastReviewedAt,
    required String status,
    String? addedAt,
    String? masteredAt,
  }) = _WordProgressDetail;

  factory WordProgressDetail.fromJson(Map<String, dynamic> json) =>
      _$WordProgressDetailFromJson(json);
}

@freezed
class UpcomingReview with _$UpcomingReview {
  const factory UpcomingReview({
    required int wordId,
    String? word,
    String? reviewDate,
    required int level,
  }) = _UpcomingReview;

  factory UpcomingReview.fromJson(Map<String, dynamic> json) =>
      _$UpcomingReviewFromJson(json);
}
