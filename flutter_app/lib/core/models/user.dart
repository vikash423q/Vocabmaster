import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String email,
    required String username,
    required String currentLevel,
    required String createdAt,
    String? lastActive,
    @Default({}) Map<String, dynamic> settings,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class UserRegister with _$UserRegister {
  const factory UserRegister({
    required String email,
    required String username,
    required String password,
    @Default('beginner') String currentLevel,
  }) = _UserRegister;

  factory UserRegister.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFromJson(json);
}

@freezed
class UserLogin with _$UserLogin {
  const factory UserLogin({
    required String email,
    required String password,
  }) = _UserLogin;

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);
}

@freezed
class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String accessToken,
    @Default('bearer') String tokenType,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}

@freezed
class UserProfileUpdate with _$UserProfileUpdate {
  const factory UserProfileUpdate({
    String? username,
    String? currentLevel,
    Map<String, dynamic>? settings,
  }) = _UserProfileUpdate;

  factory UserProfileUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserProfileUpdateFromJson(json);
}

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    required int totalWords,
    required int masteredWords,
    required int learningWords,
    required int reviewingWords,
    required int totalQuizzes,
    required int correctAnswers,
    required double accuracyRate,
    required int wordsDueToday,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}
