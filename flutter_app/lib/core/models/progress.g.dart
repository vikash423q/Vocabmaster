// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyStackItemImpl _$$DailyStackItemImplFromJson(Map<String, dynamic> json) =>
    _$DailyStackItemImpl(
      id: (json['id'] as num).toInt(),
      wordId: (json['wordId'] as num).toInt(),
      word: json['word'] as String,
      scheduledDate: json['scheduledDate'] as String,
      isReviewed: json['isReviewed'] as bool,
    );

Map<String, dynamic> _$$DailyStackItemImplToJson(
        _$DailyStackItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wordId': instance.wordId,
      'word': instance.word,
      'scheduledDate': instance.scheduledDate,
      'isReviewed': instance.isReviewed,
    };

_$AddWordsRequestImpl _$$AddWordsRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddWordsRequestImpl(
      wordIds: (json['wordIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$AddWordsRequestImplToJson(
        _$AddWordsRequestImpl instance) =>
    <String, dynamic>{
      'wordIds': instance.wordIds,
    };

_$AddWordsResponseImpl _$$AddWordsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddWordsResponseImpl(
      message: json['message'] as String,
      addedCount: (json['addedCount'] as num).toInt(),
    );

Map<String, dynamic> _$$AddWordsResponseImplToJson(
        _$AddWordsResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'addedCount': instance.addedCount,
    };

_$ReviewSubmitImpl _$$ReviewSubmitImplFromJson(Map<String, dynamic> json) =>
    _$ReviewSubmitImpl(
      wordId: (json['wordId'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
      questionType: json['questionType'] as String,
      userAnswer: json['userAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String,
      timeTakenSeconds: (json['timeTakenSeconds'] as num?)?.toInt(),
      optionsPresented: (json['optionsPresented'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ReviewSubmitImplToJson(_$ReviewSubmitImpl instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'isCorrect': instance.isCorrect,
      'questionType': instance.questionType,
      'userAnswer': instance.userAnswer,
      'correctAnswer': instance.correctAnswer,
      'timeTakenSeconds': instance.timeTakenSeconds,
      'optionsPresented': instance.optionsPresented,
    };

_$ReviewResponseImpl _$$ReviewResponseImplFromJson(Map<String, dynamic> json) =>
    _$ReviewResponseImpl(
      success: json['success'] as bool,
      newLevel: (json['newLevel'] as num).toInt(),
      nextReviewDate: json['nextReviewDate'] as String?,
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ReviewResponseImplToJson(
        _$ReviewResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'newLevel': instance.newLevel,
      'nextReviewDate': instance.nextReviewDate,
      'status': instance.status,
      'message': instance.message,
    };

_$WordProgressDetailImpl _$$WordProgressDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$WordProgressDetailImpl(
      wordId: (json['wordId'] as num).toInt(),
      word: json['word'] as String?,
      fibonacciLevel: (json['fibonacciLevel'] as num).toInt(),
      nextReviewDate: json['nextReviewDate'] as String?,
      correctCount: (json['correctCount'] as num).toInt(),
      incorrectCount: (json['incorrectCount'] as num).toInt(),
      lastReviewedAt: json['lastReviewedAt'] as String?,
      status: json['status'] as String,
      addedAt: json['addedAt'] as String?,
      masteredAt: json['masteredAt'] as String?,
    );

Map<String, dynamic> _$$WordProgressDetailImplToJson(
        _$WordProgressDetailImpl instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'word': instance.word,
      'fibonacciLevel': instance.fibonacciLevel,
      'nextReviewDate': instance.nextReviewDate,
      'correctCount': instance.correctCount,
      'incorrectCount': instance.incorrectCount,
      'lastReviewedAt': instance.lastReviewedAt,
      'status': instance.status,
      'addedAt': instance.addedAt,
      'masteredAt': instance.masteredAt,
    };

_$UpcomingReviewImpl _$$UpcomingReviewImplFromJson(Map<String, dynamic> json) =>
    _$UpcomingReviewImpl(
      wordId: (json['wordId'] as num).toInt(),
      word: json['word'] as String?,
      reviewDate: json['reviewDate'] as String?,
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$$UpcomingReviewImplToJson(
        _$UpcomingReviewImpl instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'word': instance.word,
      'reviewDate': instance.reviewDate,
      'level': instance.level,
    };
