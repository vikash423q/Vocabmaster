import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assessment.freezed.dart';
part 'assessment.g.dart';

@freezed
class AssessmentWord with _$AssessmentWord {
  const factory AssessmentWord({
    required int id,
    required String word,
    String? pronunciation,
    @JsonKey(name: 'difficulty_level') required double difficultyLevel,
    @JsonKey(name: 'cefr_level') String? cefrLevel,
  }) = _AssessmentWord;

  factory AssessmentWord.fromJson(Map<String, dynamic> json) =>
      _$AssessmentWordFromJson(json);
}

@freezed
class AssessmentStack with _$AssessmentStack {
  const factory AssessmentStack({
    required List<AssessmentWord> words,
    @JsonKey(name: 'total_words') required int totalWords,
    @JsonKey(name: 'is_first_assessment') required bool isFirstAssessment,
  }) = _AssessmentStack;

  factory AssessmentStack.fromJson(Map<String, dynamic> json) =>
      _$AssessmentStackFromJson(json);
}

@freezed
class AssessmentResponse with _$AssessmentResponse {
  const factory AssessmentResponse({
    @JsonKey(name: 'word_id') required int wordId,
    required String response, // "know", "maybe", "don't_know"
  }) = _AssessmentResponse;

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResponseFromJson(json);
}

@freezed
class AssessmentSubmit with _$AssessmentSubmit {
  const factory AssessmentSubmit({
    required List<AssessmentResponse> responses,
  }) = _AssessmentSubmit;

  factory AssessmentSubmit.fromJson(Map<String, dynamic> json) =>
      _$AssessmentSubmitFromJson(json);
}

@freezed
class AssessmentResult with _$AssessmentResult {
  const factory AssessmentResult({
    @JsonKey(name: 'calculated_level') required double calculatedLevel,
    @JsonKey(name: 'responses_count') required int responsesCount,
    @JsonKey(name: 'words_assessed') required int wordsAssessed,
  }) = _AssessmentResult;

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResultFromJson(json);
}

@freezed
class RecommendedWord with _$RecommendedWord {
  const factory RecommendedWord({
    required int id,
    required String word,
    String? pronunciation,
    @JsonKey(name: 'difficulty_level') required double difficultyLevel,
    @JsonKey(name: 'cefr_level') String? cefrLevel,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'importance_score') required int importanceScore,
  }) = _RecommendedWord;

  factory RecommendedWord.fromJson(Map<String, dynamic> json) =>
      _$RecommendedWordFromJson(json);
}

@freezed
class StackRecommendation with _$StackRecommendation {
  const factory StackRecommendation({
    required List<RecommendedWord> words,
    @JsonKey(name: 'recommended_level') required double recommendedLevel,
    @JsonKey(name: 'user_current_level') double? userCurrentLevel,
    @JsonKey(name: 'total_recommended') required int totalRecommended,
  }) = _StackRecommendation;

  factory StackRecommendation.fromJson(Map<String, dynamic> json) =>
      _$StackRecommendationFromJson(json);
}
