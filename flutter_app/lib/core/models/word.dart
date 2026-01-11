import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'category.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
class WordListItem with _$WordListItem {
  const factory WordListItem({
    required int id,
    required String word,
    String? pronunciation,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'difficulty_level') required double difficultyLevel,
    @JsonKey(name: 'importance_score') required int importanceScore,
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
    @Default(5.0) double difficultyLevel,
    @Default(50) int importanceScore,
    required String source,
    String? tone,
    @JsonKey(name: 'cefr_level') String? cefrLevel,
  }) = _WordDetail;

  factory WordDetail.fromJson(Map<String, dynamic> json) {
    return WordDetail(
      id: json['id'] as int,
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String?,
      partsOfSpeech: (json['parts_of_speech'] as List<dynamic>?)?.cast<String>() ?? [],
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => WordDefinition.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      etymology: json['etymology'] != null
          ? Etymology.fromJson(json['etymology'] as Map<String, dynamic>)
          : null,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      difficultyLevel: (json['difficulty_level'] as num?)?.toDouble() ?? 5.0,
      importanceScore: (json['importance_score'] as num?)?.toInt() ?? 50,
      source: json['source'] as String,
      tone: json['tone'] as String?,
      cefrLevel: json['cefr_level'] as String?,
    );
  }
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
    @JsonKey(name: 'parts_of_speech') @Default([]) List<String> partsOfSpeech,
    @Default([]) List<WordDefinition> definitions,
    Etymology? etymology,
    @Default([]) List<MediaItem> media,
    Category? category,
    String? tone,
    @JsonKey(name: 'cefr_level') String? cefrLevel,
  }) = _ReviewPageData;

  factory ReviewPageData.fromJson(Map<String, dynamic> json) {
    return ReviewPageData(
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String?,
      partsOfSpeech: (json['parts_of_speech'] as List<dynamic>?)?.cast<String>() ?? [],
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => WordDefinition.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      etymology: json['etymology'] != null
          ? Etymology.fromJson(json['etymology'] as Map<String, dynamic>)
          : null,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      tone: json['tone'] as String?,
      cefrLevel: json['cefr_level'] as String?,
    );
  }
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
