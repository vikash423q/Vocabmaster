// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WordListItem _$WordListItemFromJson(Map<String, dynamic> json) {
  return _WordListItem.fromJson(json);
}

/// @nodoc
mixin _$WordListItem {
  int get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'importance_score')
  int get importanceScore => throw _privateConstructorUsedError;

  /// Serializes this WordListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordListItemCopyWith<WordListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordListItemCopyWith<$Res> {
  factory $WordListItemCopyWith(
          WordListItem value, $Res Function(WordListItem) then) =
      _$WordListItemCopyWithImpl<$Res, WordListItem>;
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'importance_score') int importanceScore});
}

/// @nodoc
class _$WordListItemCopyWithImpl<$Res, $Val extends WordListItem>
    implements $WordListItemCopyWith<$Res> {
  _$WordListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? categoryId = freezed,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordListItemImplCopyWith<$Res>
    implements $WordListItemCopyWith<$Res> {
  factory _$$WordListItemImplCopyWith(
          _$WordListItemImpl value, $Res Function(_$WordListItemImpl) then) =
      __$$WordListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'importance_score') int importanceScore});
}

/// @nodoc
class __$$WordListItemImplCopyWithImpl<$Res>
    extends _$WordListItemCopyWithImpl<$Res, _$WordListItemImpl>
    implements _$$WordListItemImplCopyWith<$Res> {
  __$$WordListItemImplCopyWithImpl(
      _$WordListItemImpl _value, $Res Function(_$WordListItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? categoryId = freezed,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
  }) {
    return _then(_$WordListItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordListItemImpl implements _WordListItem {
  const _$WordListItemImpl(
      {required this.id,
      required this.word,
      this.pronunciation,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'difficulty_level') required this.difficultyLevel,
      @JsonKey(name: 'importance_score') required this.importanceScore});

  factory _$WordListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordListItemImplFromJson(json);

  @override
  final int id;
  @override
  final String word;
  @override
  final String? pronunciation;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'difficulty_level')
  final double difficultyLevel;
  @override
  @JsonKey(name: 'importance_score')
  final int importanceScore;

  @override
  String toString() {
    return 'WordListItem(id: $id, word: $word, pronunciation: $pronunciation, categoryId: $categoryId, difficultyLevel: $difficultyLevel, importanceScore: $importanceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.importanceScore, importanceScore) ||
                other.importanceScore == importanceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, word, pronunciation,
      categoryId, difficultyLevel, importanceScore);

  /// Create a copy of WordListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordListItemImplCopyWith<_$WordListItemImpl> get copyWith =>
      __$$WordListItemImplCopyWithImpl<_$WordListItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordListItemImplToJson(
      this,
    );
  }
}

abstract class _WordListItem implements WordListItem {
  const factory _WordListItem(
      {required final int id,
      required final String word,
      final String? pronunciation,
      @JsonKey(name: 'category_id') final int? categoryId,
      @JsonKey(name: 'difficulty_level') required final double difficultyLevel,
      @JsonKey(name: 'importance_score')
      required final int importanceScore}) = _$WordListItemImpl;

  factory _WordListItem.fromJson(Map<String, dynamic> json) =
      _$WordListItemImpl.fromJson;

  @override
  int get id;
  @override
  String get word;
  @override
  String? get pronunciation;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel;
  @override
  @JsonKey(name: 'importance_score')
  int get importanceScore;

  /// Create a copy of WordListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordListItemImplCopyWith<_$WordListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WordDetail {
  int get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  List<String> get partsOfSpeech => throw _privateConstructorUsedError;
  List<WordDefinition> get definitions => throw _privateConstructorUsedError;
  Etymology? get etymology => throw _privateConstructorUsedError;
  List<MediaItem> get media => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  double get difficultyLevel => throw _privateConstructorUsedError;
  int get importanceScore => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String? get tone => throw _privateConstructorUsedError;
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel => throw _privateConstructorUsedError;

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordDetailCopyWith<WordDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordDetailCopyWith<$Res> {
  factory $WordDetailCopyWith(
          WordDetail value, $Res Function(WordDetail) then) =
      _$WordDetailCopyWithImpl<$Res, WordDetail>;
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      List<String> partsOfSpeech,
      List<WordDefinition> definitions,
      Etymology? etymology,
      List<MediaItem> media,
      Category? category,
      double difficultyLevel,
      int importanceScore,
      String source,
      String? tone,
      @JsonKey(name: 'cefr_level') String? cefrLevel});

  $EtymologyCopyWith<$Res>? get etymology;
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$WordDetailCopyWithImpl<$Res, $Val extends WordDetail>
    implements $WordDetailCopyWith<$Res> {
  _$WordDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? partsOfSpeech = null,
    Object? definitions = null,
    Object? etymology = freezed,
    Object? media = null,
    Object? category = freezed,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
    Object? source = null,
    Object? tone = freezed,
    Object? cefrLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      partsOfSpeech: null == partsOfSpeech
          ? _value.partsOfSpeech
          : partsOfSpeech // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definitions: null == definitions
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<WordDefinition>,
      etymology: freezed == etymology
          ? _value.etymology
          : etymology // ignore: cast_nullable_to_non_nullable
              as Etymology?,
      media: null == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaItem>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      tone: freezed == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String?,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EtymologyCopyWith<$Res>? get etymology {
    if (_value.etymology == null) {
      return null;
    }

    return $EtymologyCopyWith<$Res>(_value.etymology!, (value) {
      return _then(_value.copyWith(etymology: value) as $Val);
    });
  }

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WordDetailImplCopyWith<$Res>
    implements $WordDetailCopyWith<$Res> {
  factory _$$WordDetailImplCopyWith(
          _$WordDetailImpl value, $Res Function(_$WordDetailImpl) then) =
      __$$WordDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      List<String> partsOfSpeech,
      List<WordDefinition> definitions,
      Etymology? etymology,
      List<MediaItem> media,
      Category? category,
      double difficultyLevel,
      int importanceScore,
      String source,
      String? tone,
      @JsonKey(name: 'cefr_level') String? cefrLevel});

  @override
  $EtymologyCopyWith<$Res>? get etymology;
  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$WordDetailImplCopyWithImpl<$Res>
    extends _$WordDetailCopyWithImpl<$Res, _$WordDetailImpl>
    implements _$$WordDetailImplCopyWith<$Res> {
  __$$WordDetailImplCopyWithImpl(
      _$WordDetailImpl _value, $Res Function(_$WordDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? partsOfSpeech = null,
    Object? definitions = null,
    Object? etymology = freezed,
    Object? media = null,
    Object? category = freezed,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
    Object? source = null,
    Object? tone = freezed,
    Object? cefrLevel = freezed,
  }) {
    return _then(_$WordDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      partsOfSpeech: null == partsOfSpeech
          ? _value._partsOfSpeech
          : partsOfSpeech // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definitions: null == definitions
          ? _value._definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<WordDefinition>,
      etymology: freezed == etymology
          ? _value.etymology
          : etymology // ignore: cast_nullable_to_non_nullable
              as Etymology?,
      media: null == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaItem>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      tone: freezed == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String?,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WordDetailImpl implements _WordDetail {
  const _$WordDetailImpl(
      {required this.id,
      required this.word,
      this.pronunciation,
      final List<String> partsOfSpeech = const [],
      final List<WordDefinition> definitions = const [],
      this.etymology,
      final List<MediaItem> media = const [],
      this.category,
      this.difficultyLevel = 5.0,
      this.importanceScore = 50,
      required this.source,
      this.tone,
      @JsonKey(name: 'cefr_level') this.cefrLevel})
      : _partsOfSpeech = partsOfSpeech,
        _definitions = definitions,
        _media = media;

  @override
  final int id;
  @override
  final String word;
  @override
  final String? pronunciation;
  final List<String> _partsOfSpeech;
  @override
  @JsonKey()
  List<String> get partsOfSpeech {
    if (_partsOfSpeech is EqualUnmodifiableListView) return _partsOfSpeech;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partsOfSpeech);
  }

  final List<WordDefinition> _definitions;
  @override
  @JsonKey()
  List<WordDefinition> get definitions {
    if (_definitions is EqualUnmodifiableListView) return _definitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_definitions);
  }

  @override
  final Etymology? etymology;
  final List<MediaItem> _media;
  @override
  @JsonKey()
  List<MediaItem> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  final Category? category;
  @override
  @JsonKey()
  final double difficultyLevel;
  @override
  @JsonKey()
  final int importanceScore;
  @override
  final String source;
  @override
  final String? tone;
  @override
  @JsonKey(name: 'cefr_level')
  final String? cefrLevel;

  @override
  String toString() {
    return 'WordDetail(id: $id, word: $word, pronunciation: $pronunciation, partsOfSpeech: $partsOfSpeech, definitions: $definitions, etymology: $etymology, media: $media, category: $category, difficultyLevel: $difficultyLevel, importanceScore: $importanceScore, source: $source, tone: $tone, cefrLevel: $cefrLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            const DeepCollectionEquality()
                .equals(other._partsOfSpeech, _partsOfSpeech) &&
            const DeepCollectionEquality()
                .equals(other._definitions, _definitions) &&
            (identical(other.etymology, etymology) ||
                other.etymology == etymology) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.importanceScore, importanceScore) ||
                other.importanceScore == importanceScore) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.cefrLevel, cefrLevel) ||
                other.cefrLevel == cefrLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      word,
      pronunciation,
      const DeepCollectionEquality().hash(_partsOfSpeech),
      const DeepCollectionEquality().hash(_definitions),
      etymology,
      const DeepCollectionEquality().hash(_media),
      category,
      difficultyLevel,
      importanceScore,
      source,
      tone,
      cefrLevel);

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordDetailImplCopyWith<_$WordDetailImpl> get copyWith =>
      __$$WordDetailImplCopyWithImpl<_$WordDetailImpl>(this, _$identity);
}

abstract class _WordDetail implements WordDetail {
  const factory _WordDetail(
      {required final int id,
      required final String word,
      final String? pronunciation,
      final List<String> partsOfSpeech,
      final List<WordDefinition> definitions,
      final Etymology? etymology,
      final List<MediaItem> media,
      final Category? category,
      final double difficultyLevel,
      final int importanceScore,
      required final String source,
      final String? tone,
      @JsonKey(name: 'cefr_level') final String? cefrLevel}) = _$WordDetailImpl;

  @override
  int get id;
  @override
  String get word;
  @override
  String? get pronunciation;
  @override
  List<String> get partsOfSpeech;
  @override
  List<WordDefinition> get definitions;
  @override
  Etymology? get etymology;
  @override
  List<MediaItem> get media;
  @override
  Category? get category;
  @override
  double get difficultyLevel;
  @override
  int get importanceScore;
  @override
  String get source;
  @override
  String? get tone;
  @override
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel;

  /// Create a copy of WordDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordDetailImplCopyWith<_$WordDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WordDefinition _$WordDefinitionFromJson(Map<String, dynamic> json) {
  return _WordDefinition.fromJson(json);
}

/// @nodoc
mixin _$WordDefinition {
  String get text => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;
  List<String> get examples => throw _privateConstructorUsedError;

  /// Serializes this WordDefinition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordDefinitionCopyWith<WordDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordDefinitionCopyWith<$Res> {
  factory $WordDefinitionCopyWith(
          WordDefinition value, $Res Function(WordDefinition) then) =
      _$WordDefinitionCopyWithImpl<$Res, WordDefinition>;
  @useResult
  $Res call({String text, bool isPrimary, List<String> examples});
}

/// @nodoc
class _$WordDefinitionCopyWithImpl<$Res, $Val extends WordDefinition>
    implements $WordDefinitionCopyWith<$Res> {
  _$WordDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isPrimary = null,
    Object? examples = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
      examples: null == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordDefinitionImplCopyWith<$Res>
    implements $WordDefinitionCopyWith<$Res> {
  factory _$$WordDefinitionImplCopyWith(_$WordDefinitionImpl value,
          $Res Function(_$WordDefinitionImpl) then) =
      __$$WordDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool isPrimary, List<String> examples});
}

/// @nodoc
class __$$WordDefinitionImplCopyWithImpl<$Res>
    extends _$WordDefinitionCopyWithImpl<$Res, _$WordDefinitionImpl>
    implements _$$WordDefinitionImplCopyWith<$Res> {
  __$$WordDefinitionImplCopyWithImpl(
      _$WordDefinitionImpl _value, $Res Function(_$WordDefinitionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordDefinition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isPrimary = null,
    Object? examples = null,
  }) {
    return _then(_$WordDefinitionImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
      examples: null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordDefinitionImpl implements _WordDefinition {
  const _$WordDefinitionImpl(
      {required this.text,
      this.isPrimary = false,
      final List<String> examples = const []})
      : _examples = examples;

  factory _$WordDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordDefinitionImplFromJson(json);

  @override
  final String text;
  @override
  @JsonKey()
  final bool isPrimary;
  final List<String> _examples;
  @override
  @JsonKey()
  List<String> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  String toString() {
    return 'WordDefinition(text: $text, isPrimary: $isPrimary, examples: $examples)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordDefinitionImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, isPrimary,
      const DeepCollectionEquality().hash(_examples));

  /// Create a copy of WordDefinition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordDefinitionImplCopyWith<_$WordDefinitionImpl> get copyWith =>
      __$$WordDefinitionImplCopyWithImpl<_$WordDefinitionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordDefinitionImplToJson(
      this,
    );
  }
}

abstract class _WordDefinition implements WordDefinition {
  const factory _WordDefinition(
      {required final String text,
      final bool isPrimary,
      final List<String> examples}) = _$WordDefinitionImpl;

  factory _WordDefinition.fromJson(Map<String, dynamic> json) =
      _$WordDefinitionImpl.fromJson;

  @override
  String get text;
  @override
  bool get isPrimary;
  @override
  List<String> get examples;

  /// Create a copy of WordDefinition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordDefinitionImplCopyWith<_$WordDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Etymology _$EtymologyFromJson(Map<String, dynamic> json) {
  return _Etymology.fromJson(json);
}

/// @nodoc
mixin _$Etymology {
  String? get originLanguage => throw _privateConstructorUsedError;
  String? get rootWord => throw _privateConstructorUsedError;
  String? get evolution => throw _privateConstructorUsedError;

  /// Serializes this Etymology to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Etymology
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EtymologyCopyWith<Etymology> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EtymologyCopyWith<$Res> {
  factory $EtymologyCopyWith(Etymology value, $Res Function(Etymology) then) =
      _$EtymologyCopyWithImpl<$Res, Etymology>;
  @useResult
  $Res call({String? originLanguage, String? rootWord, String? evolution});
}

/// @nodoc
class _$EtymologyCopyWithImpl<$Res, $Val extends Etymology>
    implements $EtymologyCopyWith<$Res> {
  _$EtymologyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Etymology
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originLanguage = freezed,
    Object? rootWord = freezed,
    Object? evolution = freezed,
  }) {
    return _then(_value.copyWith(
      originLanguage: freezed == originLanguage
          ? _value.originLanguage
          : originLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      rootWord: freezed == rootWord
          ? _value.rootWord
          : rootWord // ignore: cast_nullable_to_non_nullable
              as String?,
      evolution: freezed == evolution
          ? _value.evolution
          : evolution // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EtymologyImplCopyWith<$Res>
    implements $EtymologyCopyWith<$Res> {
  factory _$$EtymologyImplCopyWith(
          _$EtymologyImpl value, $Res Function(_$EtymologyImpl) then) =
      __$$EtymologyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? originLanguage, String? rootWord, String? evolution});
}

/// @nodoc
class __$$EtymologyImplCopyWithImpl<$Res>
    extends _$EtymologyCopyWithImpl<$Res, _$EtymologyImpl>
    implements _$$EtymologyImplCopyWith<$Res> {
  __$$EtymologyImplCopyWithImpl(
      _$EtymologyImpl _value, $Res Function(_$EtymologyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Etymology
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originLanguage = freezed,
    Object? rootWord = freezed,
    Object? evolution = freezed,
  }) {
    return _then(_$EtymologyImpl(
      originLanguage: freezed == originLanguage
          ? _value.originLanguage
          : originLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      rootWord: freezed == rootWord
          ? _value.rootWord
          : rootWord // ignore: cast_nullable_to_non_nullable
              as String?,
      evolution: freezed == evolution
          ? _value.evolution
          : evolution // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EtymologyImpl implements _Etymology {
  const _$EtymologyImpl({this.originLanguage, this.rootWord, this.evolution});

  factory _$EtymologyImpl.fromJson(Map<String, dynamic> json) =>
      _$$EtymologyImplFromJson(json);

  @override
  final String? originLanguage;
  @override
  final String? rootWord;
  @override
  final String? evolution;

  @override
  String toString() {
    return 'Etymology(originLanguage: $originLanguage, rootWord: $rootWord, evolution: $evolution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EtymologyImpl &&
            (identical(other.originLanguage, originLanguage) ||
                other.originLanguage == originLanguage) &&
            (identical(other.rootWord, rootWord) ||
                other.rootWord == rootWord) &&
            (identical(other.evolution, evolution) ||
                other.evolution == evolution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, originLanguage, rootWord, evolution);

  /// Create a copy of Etymology
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EtymologyImplCopyWith<_$EtymologyImpl> get copyWith =>
      __$$EtymologyImplCopyWithImpl<_$EtymologyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EtymologyImplToJson(
      this,
    );
  }
}

abstract class _Etymology implements Etymology {
  const factory _Etymology(
      {final String? originLanguage,
      final String? rootWord,
      final String? evolution}) = _$EtymologyImpl;

  factory _Etymology.fromJson(Map<String, dynamic> json) =
      _$EtymologyImpl.fromJson;

  @override
  String? get originLanguage;
  @override
  String? get rootWord;
  @override
  String? get evolution;

  /// Create a copy of Etymology
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EtymologyImplCopyWith<_$EtymologyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return _MediaItem.fromJson(json);
}

/// @nodoc
mixin _$MediaItem {
  String get type => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  bool get isAiGenerated => throw _privateConstructorUsedError;

  /// Serializes this MediaItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call(
      {String type,
      String url,
      String? source,
      String? caption,
      bool isAiGenerated});
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? url = null,
    Object? source = freezed,
    Object? caption = freezed,
    Object? isAiGenerated = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      isAiGenerated: null == isAiGenerated
          ? _value.isAiGenerated
          : isAiGenerated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$MediaItemImplCopyWith(
          _$MediaItemImpl value, $Res Function(_$MediaItemImpl) then) =
      __$$MediaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String url,
      String? source,
      String? caption,
      bool isAiGenerated});
}

/// @nodoc
class __$$MediaItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$MediaItemImpl>
    implements _$$MediaItemImplCopyWith<$Res> {
  __$$MediaItemImplCopyWithImpl(
      _$MediaItemImpl _value, $Res Function(_$MediaItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? url = null,
    Object? source = freezed,
    Object? caption = freezed,
    Object? isAiGenerated = null,
  }) {
    return _then(_$MediaItemImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      isAiGenerated: null == isAiGenerated
          ? _value.isAiGenerated
          : isAiGenerated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaItemImpl implements _MediaItem {
  const _$MediaItemImpl(
      {required this.type,
      required this.url,
      this.source,
      this.caption,
      this.isAiGenerated = false});

  factory _$MediaItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaItemImplFromJson(json);

  @override
  final String type;
  @override
  final String url;
  @override
  final String? source;
  @override
  final String? caption;
  @override
  @JsonKey()
  final bool isAiGenerated;

  @override
  String toString() {
    return 'MediaItem(type: $type, url: $url, source: $source, caption: $caption, isAiGenerated: $isAiGenerated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaItemImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.isAiGenerated, isAiGenerated) ||
                other.isAiGenerated == isAiGenerated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, url, source, caption, isAiGenerated);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      __$$MediaItemImplCopyWithImpl<_$MediaItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaItemImplToJson(
      this,
    );
  }
}

abstract class _MediaItem implements MediaItem {
  const factory _MediaItem(
      {required final String type,
      required final String url,
      final String? source,
      final String? caption,
      final bool isAiGenerated}) = _$MediaItemImpl;

  factory _MediaItem.fromJson(Map<String, dynamic> json) =
      _$MediaItemImpl.fromJson;

  @override
  String get type;
  @override
  String get url;
  @override
  String? get source;
  @override
  String? get caption;
  @override
  bool get isAiGenerated;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReviewPageData {
  String get word => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  @JsonKey(name: 'parts_of_speech')
  List<String> get partsOfSpeech => throw _privateConstructorUsedError;
  List<WordDefinition> get definitions => throw _privateConstructorUsedError;
  Etymology? get etymology => throw _privateConstructorUsedError;
  List<MediaItem> get media => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  String? get tone => throw _privateConstructorUsedError;
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel => throw _privateConstructorUsedError;

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewPageDataCopyWith<ReviewPageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewPageDataCopyWith<$Res> {
  factory $ReviewPageDataCopyWith(
          ReviewPageData value, $Res Function(ReviewPageData) then) =
      _$ReviewPageDataCopyWithImpl<$Res, ReviewPageData>;
  @useResult
  $Res call(
      {String word,
      String? pronunciation,
      @JsonKey(name: 'parts_of_speech') List<String> partsOfSpeech,
      List<WordDefinition> definitions,
      Etymology? etymology,
      List<MediaItem> media,
      Category? category,
      String? tone,
      @JsonKey(name: 'cefr_level') String? cefrLevel});

  $EtymologyCopyWith<$Res>? get etymology;
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$ReviewPageDataCopyWithImpl<$Res, $Val extends ReviewPageData>
    implements $ReviewPageDataCopyWith<$Res> {
  _$ReviewPageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? pronunciation = freezed,
    Object? partsOfSpeech = null,
    Object? definitions = null,
    Object? etymology = freezed,
    Object? media = null,
    Object? category = freezed,
    Object? tone = freezed,
    Object? cefrLevel = freezed,
  }) {
    return _then(_value.copyWith(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      partsOfSpeech: null == partsOfSpeech
          ? _value.partsOfSpeech
          : partsOfSpeech // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definitions: null == definitions
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<WordDefinition>,
      etymology: freezed == etymology
          ? _value.etymology
          : etymology // ignore: cast_nullable_to_non_nullable
              as Etymology?,
      media: null == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaItem>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      tone: freezed == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String?,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EtymologyCopyWith<$Res>? get etymology {
    if (_value.etymology == null) {
      return null;
    }

    return $EtymologyCopyWith<$Res>(_value.etymology!, (value) {
      return _then(_value.copyWith(etymology: value) as $Val);
    });
  }

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewPageDataImplCopyWith<$Res>
    implements $ReviewPageDataCopyWith<$Res> {
  factory _$$ReviewPageDataImplCopyWith(_$ReviewPageDataImpl value,
          $Res Function(_$ReviewPageDataImpl) then) =
      __$$ReviewPageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String word,
      String? pronunciation,
      @JsonKey(name: 'parts_of_speech') List<String> partsOfSpeech,
      List<WordDefinition> definitions,
      Etymology? etymology,
      List<MediaItem> media,
      Category? category,
      String? tone,
      @JsonKey(name: 'cefr_level') String? cefrLevel});

  @override
  $EtymologyCopyWith<$Res>? get etymology;
  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$ReviewPageDataImplCopyWithImpl<$Res>
    extends _$ReviewPageDataCopyWithImpl<$Res, _$ReviewPageDataImpl>
    implements _$$ReviewPageDataImplCopyWith<$Res> {
  __$$ReviewPageDataImplCopyWithImpl(
      _$ReviewPageDataImpl _value, $Res Function(_$ReviewPageDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? pronunciation = freezed,
    Object? partsOfSpeech = null,
    Object? definitions = null,
    Object? etymology = freezed,
    Object? media = null,
    Object? category = freezed,
    Object? tone = freezed,
    Object? cefrLevel = freezed,
  }) {
    return _then(_$ReviewPageDataImpl(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      partsOfSpeech: null == partsOfSpeech
          ? _value._partsOfSpeech
          : partsOfSpeech // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definitions: null == definitions
          ? _value._definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<WordDefinition>,
      etymology: freezed == etymology
          ? _value.etymology
          : etymology // ignore: cast_nullable_to_non_nullable
              as Etymology?,
      media: null == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaItem>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      tone: freezed == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String?,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReviewPageDataImpl implements _ReviewPageData {
  const _$ReviewPageDataImpl(
      {required this.word,
      this.pronunciation,
      @JsonKey(name: 'parts_of_speech')
      final List<String> partsOfSpeech = const [],
      final List<WordDefinition> definitions = const [],
      this.etymology,
      final List<MediaItem> media = const [],
      this.category,
      this.tone,
      @JsonKey(name: 'cefr_level') this.cefrLevel})
      : _partsOfSpeech = partsOfSpeech,
        _definitions = definitions,
        _media = media;

  @override
  final String word;
  @override
  final String? pronunciation;
  final List<String> _partsOfSpeech;
  @override
  @JsonKey(name: 'parts_of_speech')
  List<String> get partsOfSpeech {
    if (_partsOfSpeech is EqualUnmodifiableListView) return _partsOfSpeech;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partsOfSpeech);
  }

  final List<WordDefinition> _definitions;
  @override
  @JsonKey()
  List<WordDefinition> get definitions {
    if (_definitions is EqualUnmodifiableListView) return _definitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_definitions);
  }

  @override
  final Etymology? etymology;
  final List<MediaItem> _media;
  @override
  @JsonKey()
  List<MediaItem> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  final Category? category;
  @override
  final String? tone;
  @override
  @JsonKey(name: 'cefr_level')
  final String? cefrLevel;

  @override
  String toString() {
    return 'ReviewPageData(word: $word, pronunciation: $pronunciation, partsOfSpeech: $partsOfSpeech, definitions: $definitions, etymology: $etymology, media: $media, category: $category, tone: $tone, cefrLevel: $cefrLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewPageDataImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            const DeepCollectionEquality()
                .equals(other._partsOfSpeech, _partsOfSpeech) &&
            const DeepCollectionEquality()
                .equals(other._definitions, _definitions) &&
            (identical(other.etymology, etymology) ||
                other.etymology == etymology) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.cefrLevel, cefrLevel) ||
                other.cefrLevel == cefrLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      word,
      pronunciation,
      const DeepCollectionEquality().hash(_partsOfSpeech),
      const DeepCollectionEquality().hash(_definitions),
      etymology,
      const DeepCollectionEquality().hash(_media),
      category,
      tone,
      cefrLevel);

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewPageDataImplCopyWith<_$ReviewPageDataImpl> get copyWith =>
      __$$ReviewPageDataImplCopyWithImpl<_$ReviewPageDataImpl>(
          this, _$identity);
}

abstract class _ReviewPageData implements ReviewPageData {
  const factory _ReviewPageData(
          {required final String word,
          final String? pronunciation,
          @JsonKey(name: 'parts_of_speech') final List<String> partsOfSpeech,
          final List<WordDefinition> definitions,
          final Etymology? etymology,
          final List<MediaItem> media,
          final Category? category,
          final String? tone,
          @JsonKey(name: 'cefr_level') final String? cefrLevel}) =
      _$ReviewPageDataImpl;

  @override
  String get word;
  @override
  String? get pronunciation;
  @override
  @JsonKey(name: 'parts_of_speech')
  List<String> get partsOfSpeech;
  @override
  List<WordDefinition> get definitions;
  @override
  Etymology? get etymology;
  @override
  List<MediaItem> get media;
  @override
  Category? get category;
  @override
  String? get tone;
  @override
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel;

  /// Create a copy of ReviewPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewPageDataImplCopyWith<_$ReviewPageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WordCreate _$WordCreateFromJson(Map<String, dynamic> json) {
  return _WordCreate.fromJson(json);
}

/// @nodoc
mixin _$WordCreate {
  String get word => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  double get difficultyLevel => throw _privateConstructorUsedError;
  int get importanceScore => throw _privateConstructorUsedError;
  List<String> get partOfSpeech => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;

  /// Serializes this WordCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordCreateCopyWith<WordCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCreateCopyWith<$Res> {
  factory $WordCreateCopyWith(
          WordCreate value, $Res Function(WordCreate) then) =
      _$WordCreateCopyWithImpl<$Res, WordCreate>;
  @useResult
  $Res call(
      {String word,
      int categoryId,
      double difficultyLevel,
      int importanceScore,
      List<String> partOfSpeech,
      String? pronunciation,
      String source});
}

/// @nodoc
class _$WordCreateCopyWithImpl<$Res, $Val extends WordCreate>
    implements $WordCreateCopyWith<$Res> {
  _$WordCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? categoryId = null,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
    Object? partOfSpeech = null,
    Object? pronunciation = freezed,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
      partOfSpeech: null == partOfSpeech
          ? _value.partOfSpeech
          : partOfSpeech // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordCreateImplCopyWith<$Res>
    implements $WordCreateCopyWith<$Res> {
  factory _$$WordCreateImplCopyWith(
          _$WordCreateImpl value, $Res Function(_$WordCreateImpl) then) =
      __$$WordCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String word,
      int categoryId,
      double difficultyLevel,
      int importanceScore,
      List<String> partOfSpeech,
      String? pronunciation,
      String source});
}

/// @nodoc
class __$$WordCreateImplCopyWithImpl<$Res>
    extends _$WordCreateCopyWithImpl<$Res, _$WordCreateImpl>
    implements _$$WordCreateImplCopyWith<$Res> {
  __$$WordCreateImplCopyWithImpl(
      _$WordCreateImpl _value, $Res Function(_$WordCreateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? categoryId = null,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
    Object? partOfSpeech = null,
    Object? pronunciation = freezed,
    Object? source = null,
  }) {
    return _then(_$WordCreateImpl(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
      partOfSpeech: null == partOfSpeech
          ? _value._partOfSpeech
          : partOfSpeech // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordCreateImpl implements _WordCreate {
  const _$WordCreateImpl(
      {required this.word,
      required this.categoryId,
      this.difficultyLevel = 5.0,
      this.importanceScore = 50,
      final List<String> partOfSpeech = const [],
      this.pronunciation,
      this.source = 'User'})
      : _partOfSpeech = partOfSpeech;

  factory _$WordCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordCreateImplFromJson(json);

  @override
  final String word;
  @override
  final int categoryId;
  @override
  @JsonKey()
  final double difficultyLevel;
  @override
  @JsonKey()
  final int importanceScore;
  final List<String> _partOfSpeech;
  @override
  @JsonKey()
  List<String> get partOfSpeech {
    if (_partOfSpeech is EqualUnmodifiableListView) return _partOfSpeech;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partOfSpeech);
  }

  @override
  final String? pronunciation;
  @override
  @JsonKey()
  final String source;

  @override
  String toString() {
    return 'WordCreate(word: $word, categoryId: $categoryId, difficultyLevel: $difficultyLevel, importanceScore: $importanceScore, partOfSpeech: $partOfSpeech, pronunciation: $pronunciation, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordCreateImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.importanceScore, importanceScore) ||
                other.importanceScore == importanceScore) &&
            const DeepCollectionEquality()
                .equals(other._partOfSpeech, _partOfSpeech) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      word,
      categoryId,
      difficultyLevel,
      importanceScore,
      const DeepCollectionEquality().hash(_partOfSpeech),
      pronunciation,
      source);

  /// Create a copy of WordCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordCreateImplCopyWith<_$WordCreateImpl> get copyWith =>
      __$$WordCreateImplCopyWithImpl<_$WordCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordCreateImplToJson(
      this,
    );
  }
}

abstract class _WordCreate implements WordCreate {
  const factory _WordCreate(
      {required final String word,
      required final int categoryId,
      final double difficultyLevel,
      final int importanceScore,
      final List<String> partOfSpeech,
      final String? pronunciation,
      final String source}) = _$WordCreateImpl;

  factory _WordCreate.fromJson(Map<String, dynamic> json) =
      _$WordCreateImpl.fromJson;

  @override
  String get word;
  @override
  int get categoryId;
  @override
  double get difficultyLevel;
  @override
  int get importanceScore;
  @override
  List<String> get partOfSpeech;
  @override
  String? get pronunciation;
  @override
  String get source;

  /// Create a copy of WordCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordCreateImplCopyWith<_$WordCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
