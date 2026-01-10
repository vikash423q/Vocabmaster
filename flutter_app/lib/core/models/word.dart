import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
class WordListItem with _$WordListItem {
  const factory WordListItem({
    required int id,
    required String word,
    String? pronunciation,
    required int categoryId,
    required double difficultyLevel,
    required int importanceScore,
  }) = _WordListItem;

  factory WordListItem.fromJson(Map<String, dynamic> json) =>
      _$WordListItemFromJson(json);
}

@freezed
class WordDetail with _$WordDetail {
  const factory WordDetail({
    required int id,
    required String word,
    String? pronunciation,
    @Default([]) List<String> partsOfSpeech,
    @Default([]) List<WordDefinition> definitions,
    Etymology? etymology,
    @Default([]) List<MediaItem> media,
    Category? category,
    required double difficultyLevel,
    required int importanceScore,
    required String source,
  }) = _WordDetail;

  factory WordDetail.fromJson(Map<String, dynamic> json) =>
      _$WordDetailFromJson(json);
}

@freezed
class WordDefinition with _$WordDefinition {
  const factory WordDefinition({
    required String text,
    @Default(false) bool isPrimary,
    @Default([]) List<String> examples,
  }) = _WordDefinition;

  factory WordDefinition.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionFromJson(json);
}

@freezed
class Etymology with _$Etymology {
  const factory Etymology({
    String? originLanguage,
    String? rootWord,
    String? evolution,
  }) = _Etymology;

  factory Etymology.fromJson(Map<String, dynamic> json) =>
      _$EtymologyFromJson(json);
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required String type,
    required String url,
    String? source,
    String? caption,
    @Default(false) bool isAiGenerated,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
}

@freezed
class ReviewPageData with _$ReviewPageData {
  const factory ReviewPageData({
    required String word,
    String? pronunciation,
    @Default([]) List<String> partsOfSpeech,
    @Default([]) List<WordDefinition> definitions,
    Etymology? etymology,
    @Default([]) List<MediaItem> media,
    Category? category,
  }) = _ReviewPageData;

  factory ReviewPageData.fromJson(Map<String, dynamic> json) =>
      _$ReviewPageDataFromJson(json);
}

@freezed
class WordCreate with _$WordCreate {
  const factory WordCreate({
    required String word,
    required int categoryId,
    @Default(5.0) double difficultyLevel,
    @Default(50) int importanceScore,
    @Default([]) List<String> partOfSpeech,
    String? pronunciation,
    @Default('User') String source,
  }) = _WordCreate;

  factory WordCreate.fromJson(Map<String, dynamic> json) =>
      _$WordCreateFromJson(json);
}
