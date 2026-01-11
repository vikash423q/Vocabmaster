// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyStackItemImpl _$$DailyStackItemImplFromJson(Map<String, dynamic> json) =>
    _$DailyStackItemImpl(
      id: (json['id'] as num).toInt(),
      wordId: (json['word_id'] as num).toInt(),
      word: json['word'] as String,
      scheduledDate: json['scheduled_date'] as String,
      isReviewed: json['is_reviewed'] as bool,
      level: (json['level'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DailyStackItemImplToJson(
        _$DailyStackItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word_id': instance.wordId,
      'word': instance.word,
      'scheduled_date': instance.scheduledDate,
      'is_reviewed': instance.isReviewed,
      'level': instance.level,
    };

_$AddWordsRequestImpl _$$AddWordsRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddWordsRequestImpl(
      wordIds: (json['word_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$AddWordsRequestImplToJson(
        _$AddWordsRequestImpl instance) =>
    <String, dynamic>{
      'word_ids': instance.wordIds,
    };

_$AddWordsResponseImpl _$$AddWordsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddWordsResponseImpl(
      message: json['message'] as String,
      addedCount: (json['added_count'] as num).toInt(),
    );

Map<String, dynamic> _$$AddWordsResponseImplToJson(
        _$AddWordsResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'added_count': instance.addedCount,
    };

_$ReviewSubmitImpl _$$ReviewSubmitImplFromJson(Map<String, dynamic> json) =>
    _$ReviewSubmitImpl(
      wordId: (json['word_id'] as num).toInt(),
      isCorrect: json['is_correct'] as bool,
      questionType: json['question_type'] as String,
      userAnswer: json['user_answer'] as String?,
      correctAnswer: json['correct_answer'] as String,
      timeTakenSeconds: (json['time_taken_seconds'] as num?)?.toInt(),
      optionsPresented: (json['options_presented'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ReviewSubmitImplToJson(_$ReviewSubmitImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'is_correct': instance.isCorrect,
      'question_type': instance.questionType,
      'user_answer': instance.userAnswer,
      'correct_answer': instance.correctAnswer,
      'time_taken_seconds': instance.timeTakenSeconds,
      'options_presented': instance.optionsPresented,
    };

_$ReviewResponseImpl _$$ReviewResponseImplFromJson(Map<String, dynamic> json) =>
    _$ReviewResponseImpl(
      success: json['success'] as bool,
      newLevel: (json['new_level'] as num).toInt(),
      nextReviewDate: json['next_review_date'] as String?,
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ReviewResponseImplToJson(
        _$ReviewResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'new_level': instance.newLevel,
      'next_review_date': instance.nextReviewDate,
      'status': instance.status,
      'message': instance.message,
    };

_$WordProgressDetailImpl _$$WordProgressDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$WordProgressDetailImpl(
      wordId: (json['word_id'] as num).toInt(),
      word: json['word'] as String?,
      fibonacciLevel: (json['fibonacci_level'] as num).toInt(),
      nextReviewDate: json['next_review_date'] as String?,
      correctCount: (json['correct_count'] as num).toInt(),
      incorrectCount: (json['incorrect_count'] as num).toInt(),
      lastReviewedAt: json['last_reviewed_at'] as String?,
      status: json['status'] as String,
      addedAt: json['added_at'] as String?,
      masteredAt: json['mastered_at'] as String?,
    );

Map<String, dynamic> _$$WordProgressDetailImplToJson(
        _$WordProgressDetailImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'word': instance.word,
      'fibonacci_level': instance.fibonacciLevel,
      'next_review_date': instance.nextReviewDate,
      'correct_count': instance.correctCount,
      'incorrect_count': instance.incorrectCount,
      'last_reviewed_at': instance.lastReviewedAt,
      'status': instance.status,
      'added_at': instance.addedAt,
      'mastered_at': instance.masteredAt,
    };

_$UpcomingReviewImpl _$$UpcomingReviewImplFromJson(Map<String, dynamic> json) =>
    _$UpcomingReviewImpl(
      wordId: (json['word_id'] as num).toInt(),
      word: json['word'] as String?,
      reviewDate: json['review_date'] as String?,
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$$UpcomingReviewImplToJson(
        _$UpcomingReviewImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'word': instance.word,
      'review_date': instance.reviewDate,
      'level': instance.level,
    };

_$ProgressWordImpl _$$ProgressWordImplFromJson(Map<String, dynamic> json) =>
    _$ProgressWordImpl(
      id: (json['id'] as num).toInt(),
      word: json['word'] as String?,
      pronunciation: json['pronunciation'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryName: json['category_name'] as String?,
      difficultyLevel: (json['difficulty_level'] as num?)?.toDouble() ?? 5.0,
      importanceScore: (json['importance_score'] as num?)?.toInt() ?? 50,
      status: json['status'] as String,
      fibonacciLevel: (json['fibonacci_level'] as num).toInt(),
      nextReviewDate: json['next_review_date'] as String?,
      correctCount: (json['correct_count'] as num?)?.toInt() ?? 0,
      incorrectCount: (json['incorrect_count'] as num?)?.toInt() ?? 0,
      lastReviewedAt: json['last_reviewed_at'] as String?,
      addedAt: json['added_at'] as String?,
      masteredAt: json['mastered_at'] as String?,
      tone: json['tone'] as String?,
      cefrLevel: json['cefr_level'] as String?,
    );

Map<String, dynamic> _$$ProgressWordImplToJson(_$ProgressWordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'pronunciation': instance.pronunciation,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'difficulty_level': instance.difficultyLevel,
      'importance_score': instance.importanceScore,
      'status': instance.status,
      'fibonacci_level': instance.fibonacciLevel,
      'next_review_date': instance.nextReviewDate,
      'correct_count': instance.correctCount,
      'incorrect_count': instance.incorrectCount,
      'last_reviewed_at': instance.lastReviewedAt,
      'added_at': instance.addedAt,
      'mastered_at': instance.masteredAt,
      'tone': instance.tone,
      'cefr_level': instance.cefrLevel,
    };

_$ProgressWordsResponseImpl _$$ProgressWordsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgressWordsResponseImpl(
      words: (json['words'] as List<dynamic>)
          .map((e) => ProgressWord.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$ProgressWordsResponseImplToJson(
        _$ProgressWordsResponseImpl instance) =>
    <String, dynamic>{
      'words': instance.words,
      'total': instance.total,
      'status': instance.status,
    };

_$MCQQuestionImpl _$$MCQQuestionImplFromJson(Map<String, dynamic> json) =>
    _$MCQQuestionImpl(
      wordId: (json['word_id'] as num).toInt(),
      word: json['word'] as String,
      definition: json['definition'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correct_answer'] as String,
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$$MCQQuestionImplToJson(_$MCQQuestionImpl instance) =>
    <String, dynamic>{
      'word_id': instance.wordId,
      'word': instance.word,
      'definition': instance.definition,
      'options': instance.options,
      'correct_answer': instance.correctAnswer,
      'level': instance.level,
    };
