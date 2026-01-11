// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordListItemImpl _$$WordListItemImplFromJson(Map<String, dynamic> json) =>
    _$WordListItemImpl(
      id: (json['id'] as num).toInt(),
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      difficultyLevel: (json['difficulty_level'] as num).toDouble(),
      importanceScore: (json['importance_score'] as num).toInt(),
    );

Map<String, dynamic> _$$WordListItemImplToJson(_$WordListItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'pronunciation': instance.pronunciation,
      'category_id': instance.categoryId,
      'difficulty_level': instance.difficultyLevel,
      'importance_score': instance.importanceScore,
    };

_$WordDefinitionImpl _$$WordDefinitionImplFromJson(Map<String, dynamic> json) =>
    _$WordDefinitionImpl(
      text: json['text'] as String,
      isPrimary: json['isPrimary'] as bool? ?? false,
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WordDefinitionImplToJson(
        _$WordDefinitionImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isPrimary': instance.isPrimary,
      'examples': instance.examples,
    };

_$EtymologyImpl _$$EtymologyImplFromJson(Map<String, dynamic> json) =>
    _$EtymologyImpl(
      originLanguage: json['originLanguage'] as String?,
      rootWord: json['rootWord'] as String?,
      evolution: json['evolution'] as String?,
    );

Map<String, dynamic> _$$EtymologyImplToJson(_$EtymologyImpl instance) =>
    <String, dynamic>{
      'originLanguage': instance.originLanguage,
      'rootWord': instance.rootWord,
      'evolution': instance.evolution,
    };

_$MediaItemImpl _$$MediaItemImplFromJson(Map<String, dynamic> json) =>
    _$MediaItemImpl(
      type: json['type'] as String,
      url: json['url'] as String,
      source: json['source'] as String?,
      caption: json['caption'] as String?,
      isAiGenerated: json['isAiGenerated'] as bool? ?? false,
    );

Map<String, dynamic> _$$MediaItemImplToJson(_$MediaItemImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'source': instance.source,
      'caption': instance.caption,
      'isAiGenerated': instance.isAiGenerated,
    };

_$WordCreateImpl _$$WordCreateImplFromJson(Map<String, dynamic> json) =>
    _$WordCreateImpl(
      word: json['word'] as String,
      categoryId: (json['categoryId'] as num).toInt(),
      difficultyLevel: (json['difficultyLevel'] as num?)?.toDouble() ?? 5.0,
      importanceScore: (json['importanceScore'] as num?)?.toInt() ?? 50,
      partOfSpeech: (json['partOfSpeech'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      pronunciation: json['pronunciation'] as String?,
      source: json['source'] as String? ?? 'User',
    );

Map<String, dynamic> _$$WordCreateImplToJson(_$WordCreateImpl instance) =>
    <String, dynamic>{
      'word': instance.word,
      'categoryId': instance.categoryId,
      'difficultyLevel': instance.difficultyLevel,
      'importanceScore': instance.importanceScore,
      'partOfSpeech': instance.partOfSpeech,
      'pronunciation': instance.pronunciation,
      'source': instance.source,
    };
