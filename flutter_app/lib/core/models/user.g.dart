// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      username: json['username'] as String,
      currentLevel: (json['current_level'] as num?)?.toDouble(),
      createdAt: json['created_at'] as String,
      lastActive: json['last_active'] as String?,
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'current_level': instance.currentLevel,
      'created_at': instance.createdAt,
      'last_active': instance.lastActive,
      'settings': instance.settings,
    };

_$UserRegisterImpl _$$UserRegisterImplFromJson(Map<String, dynamic> json) =>
    _$UserRegisterImpl(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$UserRegisterImplToJson(_$UserRegisterImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
    };

_$UserLoginImpl _$$UserLoginImplFromJson(Map<String, dynamic> json) =>
    _$UserLoginImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$UserLoginImplToJson(_$UserLoginImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };

_$UserProfileUpdateImpl _$$UserProfileUpdateImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileUpdateImpl(
      username: json['username'] as String?,
      currentLevel: (json['currentLevel'] as num?)?.toDouble(),
      settings: json['settings'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UserProfileUpdateImplToJson(
        _$UserProfileUpdateImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'currentLevel': instance.currentLevel,
      'settings': instance.settings,
    };

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      totalWords: (json['total_words'] as num).toInt(),
      masteredWords: (json['mastered_words'] as num).toInt(),
      learningWords: (json['learning_words'] as num).toInt(),
      reviewingWords: (json['reviewing_words'] as num).toInt(),
      totalQuizzes: (json['total_quizzes'] as num).toInt(),
      correctAnswers: (json['correct_answers'] as num).toInt(),
      accuracyRate: (json['accuracy_rate'] as num).toDouble(),
      wordsDueToday: (json['words_due_today'] as num).toInt(),
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'total_words': instance.totalWords,
      'mastered_words': instance.masteredWords,
      'learning_words': instance.learningWords,
      'reviewing_words': instance.reviewingWords,
      'total_quizzes': instance.totalQuizzes,
      'correct_answers': instance.correctAnswers,
      'accuracy_rate': instance.accuracyRate,
      'words_due_today': instance.wordsDueToday,
    };
