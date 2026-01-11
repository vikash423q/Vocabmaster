// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssessmentWordImpl _$$AssessmentWordImplFromJson(Map<String, dynamic> json) =>
    _$AssessmentWordImpl(
      id: (json['id'] as num).toInt(),
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String?,
      difficultyLevel: (json['difficulty_level'] as num).toDouble(),
      cefrLevel: json['cefr_level'] as String?,
    );

Map<String, dynamic> _$$AssessmentWordImplToJson(
        _$AssessmentWordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'pronunciation': instance.pronunciation,
      'difficulty_level': instance.difficultyLevel,
      'cefr_level': instance.cefrLevel,
    };

_$AssessmentStackImpl _$$AssessmentStackImplFromJson(
        Map<String, dynamic> json) =>
    _$AssessmentStackImpl(
      words: (json['words'] as List<dynamic>)
          .map((e) => AssessmentWord.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalWords: (json['total_words'] as num).toInt(),
      isFirstAssessment: json['is_first_assessment'] as bool,
    );

Map<String, dynamic> _$$AssessmentStackImplToJson(
        _$AssessmentStackImpl instance) =>
    <String, dynamic>{
      'words': instance.words,
      'total_words': instance.totalWords,
      'is_first_assessment': instance.isFirstAssessment,
    };

_$AssessmentResponseImpl _$$AssessmentResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AssessmentResponseImpl(
      wordId: (json['word_id'] as num).toInt(),
      response: json['response'] as String,
    );

Map<String, dynamic> _$$AssessmentResponseImplToJson(
        _$AssessmentResponseImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'response': instance.response,
    };

_$AssessmentSubmitImpl _$$AssessmentSubmitImplFromJson(
        Map<String, dynamic> json) =>
    _$AssessmentSubmitImpl(
      responses: (json['responses'] as List<dynamic>)
          .map((e) => AssessmentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AssessmentSubmitImplToJson(
        _$AssessmentSubmitImpl instance) =>
    <String, dynamic>{
      'responses': instance.responses,
    };

_$AssessmentResultImpl _$$AssessmentResultImplFromJson(
        Map<String, dynamic> json) =>
    _$AssessmentResultImpl(
      calculatedLevel: (json['calculated_level'] as num).toDouble(),
      responsesCount: (json['responses_count'] as num).toInt(),
      wordsAssessed: (json['words_assessed'] as num).toInt(),
    );

Map<String, dynamic> _$$AssessmentResultImplToJson(
        _$AssessmentResultImpl instance) =>
    <String, dynamic>{
      'calculated_level': instance.calculatedLevel,
      'responses_count': instance.responsesCount,
      'words_assessed': instance.wordsAssessed,
    };

_$RecommendedWordImpl _$$RecommendedWordImplFromJson(
        Map<String, dynamic> json) =>
    _$RecommendedWordImpl(
      id: (json['id'] as num).toInt(),
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String?,
      difficultyLevel: (json['difficulty_level'] as num).toDouble(),
      cefrLevel: json['cefr_level'] as String?,
      categoryId: (json['category_id'] as num).toInt(),
      categoryName: json['category_name'] as String?,
      importanceScore: (json['importance_score'] as num).toInt(),
    );

Map<String, dynamic> _$$RecommendedWordImplToJson(
        _$RecommendedWordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'pronunciation': instance.pronunciation,
      'difficulty_level': instance.difficultyLevel,
      'cefr_level': instance.cefrLevel,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'importance_score': instance.importanceScore,
    };

_$StackRecommendationImpl _$$StackRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$StackRecommendationImpl(
      words: (json['words'] as List<dynamic>)
          .map((e) => RecommendedWord.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedLevel: (json['recommended_level'] as num).toDouble(),
      userCurrentLevel: (json['user_current_level'] as num?)?.toDouble(),
      totalRecommended: (json['total_recommended'] as num).toInt(),
    );

Map<String, dynamic> _$$StackRecommendationImplToJson(
        _$StackRecommendationImpl instance) =>
    <String, dynamic>{
      'words': instance.words,
      'recommended_level': instance.recommendedLevel,
      'user_current_level': instance.userCurrentLevel,
      'total_recommended': instance.totalRecommended,
    };
