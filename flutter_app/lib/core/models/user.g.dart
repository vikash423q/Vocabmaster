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
      currentLevel: json['currentLevel'] as String,
      createdAt: json['createdAt'] as String,
      lastActive: json['lastActive'] as String?,
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'currentLevel': instance.currentLevel,
      'createdAt': instance.createdAt,
      'lastActive': instance.lastActive,
      'settings': instance.settings,
    };

_$UserRegisterImpl _$$UserRegisterImplFromJson(Map<String, dynamic> json) =>
    _$UserRegisterImpl(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      currentLevel: json['currentLevel'] as String? ?? 'beginner',
    );

Map<String, dynamic> _$$UserRegisterImplToJson(_$UserRegisterImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'currentLevel': instance.currentLevel,
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
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String? ?? 'bearer',
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
    };

_$UserProfileUpdateImpl _$$UserProfileUpdateImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileUpdateImpl(
      username: json['username'] as String?,
      currentLevel: json['currentLevel'] as String?,
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
      totalWords: (json['totalWords'] as num).toInt(),
      masteredWords: (json['masteredWords'] as num).toInt(),
      learningWords: (json['learningWords'] as num).toInt(),
      reviewingWords: (json['reviewingWords'] as num).toInt(),
      totalQuizzes: (json['totalQuizzes'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      accuracyRate: (json['accuracyRate'] as num).toDouble(),
      wordsDueToday: (json['wordsDueToday'] as num).toInt(),
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'totalWords': instance.totalWords,
      'masteredWords': instance.masteredWords,
      'learningWords': instance.learningWords,
      'reviewingWords': instance.reviewingWords,
      'totalQuizzes': instance.totalQuizzes,
      'correctAnswers': instance.correctAnswers,
      'accuracyRate': instance.accuracyRate,
      'wordsDueToday': instance.wordsDueToday,
    };
