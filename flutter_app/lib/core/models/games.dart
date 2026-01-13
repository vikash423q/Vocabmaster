import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'games.freezed.dart';
part 'games.g.dart';

@freezed
class GamesListResponse with _$GamesListResponse {
  const factory GamesListResponse({
    required String message,
    @JsonKey(name: 'available_games') required List<String> availableGames,
  }) = _GamesListResponse;

  factory GamesListResponse.fromJson(Map<String, dynamic> json) =>
      _$GamesListResponseFromJson(json);
}

@freezed
class IceburstGameWord with _$IceburstGameWord {
  const factory IceburstGameWord({
    required String word,
    @JsonKey(name: 'word_id') required int wordId,
    required String synonym,
    @JsonKey(name: 'difficulty_level') required double difficultyLevel,
  }) = _IceburstGameWord;

  factory IceburstGameWord.fromJson(Map<String, dynamic> json) =>
      _$IceburstGameWordFromJson(json);
}

@freezed
class IceburstGridItem with _$IceburstGridItem {
  const factory IceburstGridItem({
    required String id,
    required String text,
    required String type,
    @JsonKey(name: 'pair_id') required int pairId,
  }) = _IceburstGridItem;

  factory IceburstGridItem.fromJson(Map<String, dynamic> json) =>
      _$IceburstGridItemFromJson(json);
}

@freezed
class IceburstGameResponse with _$IceburstGameResponse {
  const factory IceburstGameResponse({
    @JsonKey(name: 'game_type') required String gameType,
    required int level,
    @JsonKey(name: 'difficulty_range') required DifficultyRange difficultyRange,
    required List<IceburstGameWord> words,
    required List<IceburstGridItem> grid,
    @JsonKey(name: 'grid_size') required GridSize gridSize,
    @JsonKey(name: 'timer_seconds') required int timerSeconds,
  }) = _IceburstGameResponse;

  factory IceburstGameResponse.fromJson(Map<String, dynamic> json) =>
      _$IceburstGameResponseFromJson(json);
}

@freezed
class DifficultyRange with _$DifficultyRange {
  const factory DifficultyRange({
    required double min,
    required double max,
  }) = _DifficultyRange;

  factory DifficultyRange.fromJson(Map<String, dynamic> json) =>
      _$DifficultyRangeFromJson(json);
}

@freezed
class GridSize with _$GridSize {
  const factory GridSize({
    required int rows,
    required int cols,
  }) = _GridSize;

  factory GridSize.fromJson(Map<String, dynamic> json) =>
      _$GridSizeFromJson(json);
}
