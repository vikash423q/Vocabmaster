import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String email,
    required String username,
    @JsonKey(name: 'current_level') double? currentLevel, // Nullable double - null means not assessed yet
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'last_active') String? lastActive,
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
    // currentLevel is set during assessment, not during registration
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
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') @Default('bearer') String tokenType,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}

@freezed
class UserProfileUpdate with _$UserProfileUpdate {
  const factory UserProfileUpdate({
    String? username,
    double? currentLevel, // Double instead of String
    Map<String, dynamic>? settings,
  }) = _UserProfileUpdate;

  factory UserProfileUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserProfileUpdateFromJson(json);
}

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    @JsonKey(name: 'total_words') required int totalWords,
    @JsonKey(name: 'mastered_words') required int masteredWords,
    @JsonKey(name: 'learning_words') required int learningWords,
    @JsonKey(name: 'reviewing_words') required int reviewingWords,
    @JsonKey(name: 'total_quizzes') required int totalQuizzes,
    @JsonKey(name: 'correct_answers') required int correctAnswers,
    @JsonKey(name: 'accuracy_rate') required double accuracyRate,
    @JsonKey(name: 'words_due_today') required int wordsDueToday,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}
