import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class QuizGenerateRequest with _$QuizGenerateRequest {
  const factory QuizGenerateRequest({
    required int wordId,
  }) = _QuizGenerateRequest;

  factory QuizGenerateRequest.fromJson(Map<String, dynamic> json) =>
      _$QuizGenerateRequestFromJson(json);
}

@freezed
class QuizOption with _$QuizOption {
  const factory QuizOption({
    required String text,
    @Default(false) bool isCorrect,
  }) = _QuizOption;

  factory QuizOption.fromJson(Map<String, dynamic> json) =>
      _$QuizOptionFromJson(json);
}

@freezed
class QuizResponse with _$QuizResponse {
  const factory QuizResponse({
    required String question,
    required List<QuizOption> options,
    required String correctAnswer,
    String? explanation,
  }) = _QuizResponse;

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);
}

@freezed
class ExplainRequest with _$ExplainRequest {
  const factory ExplainRequest({
    required int wordId,
    required String question,
  }) = _ExplainRequest;

  factory ExplainRequest.fromJson(Map<String, dynamic> json) =>
      _$ExplainRequestFromJson(json);
}

@freezed
class ExplainResponse with _$ExplainResponse {
  const factory ExplainResponse({
    required String answer,
  }) = _ExplainResponse;

  factory ExplainResponse.fromJson(Map<String, dynamic> json) =>
      _$ExplainResponseFromJson(json);
}

@freezed
class StoryGenerateRequest with _$StoryGenerateRequest {
  const factory StoryGenerateRequest({
    List<int>? wordIds,
    @Default(20) int batchSize,
    @Default('daily') String storyType,
  }) = _StoryGenerateRequest;

  factory StoryGenerateRequest.fromJson(Map<String, dynamic> json) =>
      _$StoryGenerateRequestFromJson(json);
}

@freezed
class StoryResponse with _$StoryResponse {
  const factory StoryResponse({
    required int storyId,
    required String narrative,
    required List<int> wordIds,
    required String storyType,
  }) = _StoryResponse;

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);
}

@freezed
class ChatRequest with _$ChatRequest {
  const factory ChatRequest({
    required int wordId,
    required String message,
  }) = _ChatRequest;

  factory ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestFromJson(json);
}

@freezed
class ChatResponse with _$ChatResponse {
  const factory ChatResponse({
    required String response,
  }) = _ChatResponse;

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
}
