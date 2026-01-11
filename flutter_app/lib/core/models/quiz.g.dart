// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizGenerateRequestImpl _$$QuizGenerateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QuizGenerateRequestImpl(
      wordId: (json['word_id'] as num).toInt(),
    );

Map<String, dynamic> _$$QuizGenerateRequestImplToJson(
        _$QuizGenerateRequestImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
    };

_$QuizOptionImpl _$$QuizOptionImplFromJson(Map<String, dynamic> json) =>
    _$QuizOptionImpl(
      text: json['text'] as String,
      isCorrect: json['is_correct'] as bool? ?? false,
    );

Map<String, dynamic> _$$QuizOptionImplToJson(_$QuizOptionImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'is_correct': instance.isCorrect,
    };

_$QuizResponseImpl _$$QuizResponseImplFromJson(Map<String, dynamic> json) =>
    _$QuizResponseImpl(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => QuizOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer: json['correct_answer'] as String,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$$QuizResponseImplToJson(_$QuizResponseImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correct_answer': instance.correctAnswer,
      'explanation': instance.explanation,
    };

_$ExplainRequestImpl _$$ExplainRequestImplFromJson(Map<String, dynamic> json) =>
    _$ExplainRequestImpl(
      wordId: (json['word_id'] as num).toInt(),
      question: json['question'] as String,
    );

Map<String, dynamic> _$$ExplainRequestImplToJson(
        _$ExplainRequestImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'question': instance.question,
    };

_$ExplainResponseImpl _$$ExplainResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplainResponseImpl(
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$$ExplainResponseImplToJson(
        _$ExplainResponseImpl instance) =>
    <String, dynamic>{
      'answer': instance.answer,
    };

_$StoryGenerateRequestImpl _$$StoryGenerateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$StoryGenerateRequestImpl(
      wordIds: (json['word_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      batchSize: (json['batch_size'] as num?)?.toInt() ?? 20,
      storyType: json['story_type'] as String? ?? 'daily',
    );

Map<String, dynamic> _$$StoryGenerateRequestImplToJson(
        _$StoryGenerateRequestImpl instance) =>
    <String, dynamic>{
      'word_ids': instance.wordIds,
      'batch_size': instance.batchSize,
      'story_type': instance.storyType,
    };

_$StoryResponseImpl _$$StoryResponseImplFromJson(Map<String, dynamic> json) =>
    _$StoryResponseImpl(
      storyId: (json['story_id'] as num).toInt(),
      narrative: json['narrative'] as String,
      wordIds: (json['word_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      storyType: json['story_type'] as String,
    );

Map<String, dynamic> _$$StoryResponseImplToJson(_$StoryResponseImpl instance) =>
    <String, dynamic>{
      'story_id': instance.storyId,
      'narrative': instance.narrative,
      'word_ids': instance.wordIds,
      'story_type': instance.storyType,
    };

_$ChatRequestImpl _$$ChatRequestImplFromJson(Map<String, dynamic> json) =>
    _$ChatRequestImpl(
      wordId: (json['word_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ChatRequestImplToJson(_$ChatRequestImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'message': instance.message,
    };

_$ChatResponseImpl _$$ChatResponseImplFromJson(Map<String, dynamic> json) =>
    _$ChatResponseImpl(
      response: json['response'] as String,
    );

Map<String, dynamic> _$$ChatResponseImplToJson(_$ChatResponseImpl instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
