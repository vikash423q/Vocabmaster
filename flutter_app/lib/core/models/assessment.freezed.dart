// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AssessmentWord _$AssessmentWordFromJson(Map<String, dynamic> json) {
  return _AssessmentWord.fromJson(json);
}

/// @nodoc
mixin _$AssessmentWord {
  int get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel => throw _privateConstructorUsedError;

  /// Serializes this AssessmentWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentWordCopyWith<AssessmentWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentWordCopyWith<$Res> {
  factory $AssessmentWordCopyWith(
          AssessmentWord value, $Res Function(AssessmentWord) then) =
      _$AssessmentWordCopyWithImpl<$Res, AssessmentWord>;
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'cefr_level') String? cefrLevel});
}

/// @nodoc
class _$AssessmentWordCopyWithImpl<$Res, $Val extends AssessmentWord>
    implements $AssessmentWordCopyWith<$Res> {
  _$AssessmentWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? difficultyLevel = null,
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
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentWordImplCopyWith<$Res>
    implements $AssessmentWordCopyWith<$Res> {
  factory _$$AssessmentWordImplCopyWith(_$AssessmentWordImpl value,
          $Res Function(_$AssessmentWordImpl) then) =
      __$$AssessmentWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'cefr_level') String? cefrLevel});
}

/// @nodoc
class __$$AssessmentWordImplCopyWithImpl<$Res>
    extends _$AssessmentWordCopyWithImpl<$Res, _$AssessmentWordImpl>
    implements _$$AssessmentWordImplCopyWith<$Res> {
  __$$AssessmentWordImplCopyWithImpl(
      _$AssessmentWordImpl _value, $Res Function(_$AssessmentWordImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssessmentWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? difficultyLevel = null,
    Object? cefrLevel = freezed,
  }) {
    return _then(_$AssessmentWordImpl(
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
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentWordImpl implements _AssessmentWord {
  const _$AssessmentWordImpl(
      {required this.id,
      required this.word,
      this.pronunciation,
      @JsonKey(name: 'difficulty_level') required this.difficultyLevel,
      @JsonKey(name: 'cefr_level') this.cefrLevel});

  factory _$AssessmentWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentWordImplFromJson(json);

  @override
  final int id;
  @override
  final String word;
  @override
  final String? pronunciation;
  @override
  @JsonKey(name: 'difficulty_level')
  final double difficultyLevel;
  @override
  @JsonKey(name: 'cefr_level')
  final String? cefrLevel;

  @override
  String toString() {
    return 'AssessmentWord(id: $id, word: $word, pronunciation: $pronunciation, difficultyLevel: $difficultyLevel, cefrLevel: $cefrLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentWordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.cefrLevel, cefrLevel) ||
                other.cefrLevel == cefrLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, word, pronunciation, difficultyLevel, cefrLevel);

  /// Create a copy of AssessmentWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentWordImplCopyWith<_$AssessmentWordImpl> get copyWith =>
      __$$AssessmentWordImplCopyWithImpl<_$AssessmentWordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentWordImplToJson(
      this,
    );
  }
}

abstract class _AssessmentWord implements AssessmentWord {
  const factory _AssessmentWord(
      {required final int id,
      required final String word,
      final String? pronunciation,
      @JsonKey(name: 'difficulty_level') required final double difficultyLevel,
      @JsonKey(name: 'cefr_level')
      final String? cefrLevel}) = _$AssessmentWordImpl;

  factory _AssessmentWord.fromJson(Map<String, dynamic> json) =
      _$AssessmentWordImpl.fromJson;

  @override
  int get id;
  @override
  String get word;
  @override
  String? get pronunciation;
  @override
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel;
  @override
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel;

  /// Create a copy of AssessmentWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentWordImplCopyWith<_$AssessmentWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssessmentStack _$AssessmentStackFromJson(Map<String, dynamic> json) {
  return _AssessmentStack.fromJson(json);
}

/// @nodoc
mixin _$AssessmentStack {
  List<AssessmentWord> get words => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_words')
  int get totalWords => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_first_assessment')
  bool get isFirstAssessment => throw _privateConstructorUsedError;

  /// Serializes this AssessmentStack to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentStack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentStackCopyWith<AssessmentStack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentStackCopyWith<$Res> {
  factory $AssessmentStackCopyWith(
          AssessmentStack value, $Res Function(AssessmentStack) then) =
      _$AssessmentStackCopyWithImpl<$Res, AssessmentStack>;
  @useResult
  $Res call(
      {List<AssessmentWord> words,
      @JsonKey(name: 'total_words') int totalWords,
      @JsonKey(name: 'is_first_assessment') bool isFirstAssessment});
}

/// @nodoc
class _$AssessmentStackCopyWithImpl<$Res, $Val extends AssessmentStack>
    implements $AssessmentStackCopyWith<$Res> {
  _$AssessmentStackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentStack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? totalWords = null,
    Object? isFirstAssessment = null,
  }) {
    return _then(_value.copyWith(
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<AssessmentWord>,
      totalWords: null == totalWords
          ? _value.totalWords
          : totalWords // ignore: cast_nullable_to_non_nullable
              as int,
      isFirstAssessment: null == isFirstAssessment
          ? _value.isFirstAssessment
          : isFirstAssessment // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentStackImplCopyWith<$Res>
    implements $AssessmentStackCopyWith<$Res> {
  factory _$$AssessmentStackImplCopyWith(_$AssessmentStackImpl value,
          $Res Function(_$AssessmentStackImpl) then) =
      __$$AssessmentStackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AssessmentWord> words,
      @JsonKey(name: 'total_words') int totalWords,
      @JsonKey(name: 'is_first_assessment') bool isFirstAssessment});
}

/// @nodoc
class __$$AssessmentStackImplCopyWithImpl<$Res>
    extends _$AssessmentStackCopyWithImpl<$Res, _$AssessmentStackImpl>
    implements _$$AssessmentStackImplCopyWith<$Res> {
  __$$AssessmentStackImplCopyWithImpl(
      _$AssessmentStackImpl _value, $Res Function(_$AssessmentStackImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssessmentStack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? totalWords = null,
    Object? isFirstAssessment = null,
  }) {
    return _then(_$AssessmentStackImpl(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<AssessmentWord>,
      totalWords: null == totalWords
          ? _value.totalWords
          : totalWords // ignore: cast_nullable_to_non_nullable
              as int,
      isFirstAssessment: null == isFirstAssessment
          ? _value.isFirstAssessment
          : isFirstAssessment // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentStackImpl implements _AssessmentStack {
  const _$AssessmentStackImpl(
      {required final List<AssessmentWord> words,
      @JsonKey(name: 'total_words') required this.totalWords,
      @JsonKey(name: 'is_first_assessment') required this.isFirstAssessment})
      : _words = words;

  factory _$AssessmentStackImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentStackImplFromJson(json);

  final List<AssessmentWord> _words;
  @override
  List<AssessmentWord> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  @JsonKey(name: 'total_words')
  final int totalWords;
  @override
  @JsonKey(name: 'is_first_assessment')
  final bool isFirstAssessment;

  @override
  String toString() {
    return 'AssessmentStack(words: $words, totalWords: $totalWords, isFirstAssessment: $isFirstAssessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentStackImpl &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.totalWords, totalWords) ||
                other.totalWords == totalWords) &&
            (identical(other.isFirstAssessment, isFirstAssessment) ||
                other.isFirstAssessment == isFirstAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_words),
      totalWords,
      isFirstAssessment);

  /// Create a copy of AssessmentStack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentStackImplCopyWith<_$AssessmentStackImpl> get copyWith =>
      __$$AssessmentStackImplCopyWithImpl<_$AssessmentStackImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentStackImplToJson(
      this,
    );
  }
}

abstract class _AssessmentStack implements AssessmentStack {
  const factory _AssessmentStack(
      {required final List<AssessmentWord> words,
      @JsonKey(name: 'total_words') required final int totalWords,
      @JsonKey(name: 'is_first_assessment')
      required final bool isFirstAssessment}) = _$AssessmentStackImpl;

  factory _AssessmentStack.fromJson(Map<String, dynamic> json) =
      _$AssessmentStackImpl.fromJson;

  @override
  List<AssessmentWord> get words;
  @override
  @JsonKey(name: 'total_words')
  int get totalWords;
  @override
  @JsonKey(name: 'is_first_assessment')
  bool get isFirstAssessment;

  /// Create a copy of AssessmentStack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentStackImplCopyWith<_$AssessmentStackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssessmentResponse _$AssessmentResponseFromJson(Map<String, dynamic> json) {
  return _AssessmentResponse.fromJson(json);
}

/// @nodoc
mixin _$AssessmentResponse {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String get response => throw _privateConstructorUsedError;

  /// Serializes this AssessmentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentResponseCopyWith<AssessmentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentResponseCopyWith<$Res> {
  factory $AssessmentResponseCopyWith(
          AssessmentResponse value, $Res Function(AssessmentResponse) then) =
      _$AssessmentResponseCopyWithImpl<$Res, AssessmentResponse>;
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId, String response});
}

/// @nodoc
class _$AssessmentResponseCopyWithImpl<$Res, $Val extends AssessmentResponse>
    implements $AssessmentResponseCopyWith<$Res> {
  _$AssessmentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentResponseImplCopyWith<$Res>
    implements $AssessmentResponseCopyWith<$Res> {
  factory _$$AssessmentResponseImplCopyWith(_$AssessmentResponseImpl value,
          $Res Function(_$AssessmentResponseImpl) then) =
      __$$AssessmentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId, String response});
}

/// @nodoc
class __$$AssessmentResponseImplCopyWithImpl<$Res>
    extends _$AssessmentResponseCopyWithImpl<$Res, _$AssessmentResponseImpl>
    implements _$$AssessmentResponseImplCopyWith<$Res> {
  __$$AssessmentResponseImplCopyWithImpl(_$AssessmentResponseImpl _value,
      $Res Function(_$AssessmentResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssessmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? response = null,
  }) {
    return _then(_$AssessmentResponseImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentResponseImpl implements _AssessmentResponse {
  const _$AssessmentResponseImpl(
      {@JsonKey(name: 'word_id') required this.wordId, required this.response});

  factory _$AssessmentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentResponseImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String response;

  @override
  String toString() {
    return 'AssessmentResponse(wordId: $wordId, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentResponseImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wordId, response);

  /// Create a copy of AssessmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentResponseImplCopyWith<_$AssessmentResponseImpl> get copyWith =>
      __$$AssessmentResponseImplCopyWithImpl<_$AssessmentResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentResponseImplToJson(
      this,
    );
  }
}

abstract class _AssessmentResponse implements AssessmentResponse {
  const factory _AssessmentResponse(
      {@JsonKey(name: 'word_id') required final int wordId,
      required final String response}) = _$AssessmentResponseImpl;

  factory _AssessmentResponse.fromJson(Map<String, dynamic> json) =
      _$AssessmentResponseImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String get response;

  /// Create a copy of AssessmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentResponseImplCopyWith<_$AssessmentResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssessmentSubmit _$AssessmentSubmitFromJson(Map<String, dynamic> json) {
  return _AssessmentSubmit.fromJson(json);
}

/// @nodoc
mixin _$AssessmentSubmit {
  List<AssessmentResponse> get responses => throw _privateConstructorUsedError;

  /// Serializes this AssessmentSubmit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentSubmit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentSubmitCopyWith<AssessmentSubmit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentSubmitCopyWith<$Res> {
  factory $AssessmentSubmitCopyWith(
          AssessmentSubmit value, $Res Function(AssessmentSubmit) then) =
      _$AssessmentSubmitCopyWithImpl<$Res, AssessmentSubmit>;
  @useResult
  $Res call({List<AssessmentResponse> responses});
}

/// @nodoc
class _$AssessmentSubmitCopyWithImpl<$Res, $Val extends AssessmentSubmit>
    implements $AssessmentSubmitCopyWith<$Res> {
  _$AssessmentSubmitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentSubmit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responses = null,
  }) {
    return _then(_value.copyWith(
      responses: null == responses
          ? _value.responses
          : responses // ignore: cast_nullable_to_non_nullable
              as List<AssessmentResponse>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentSubmitImplCopyWith<$Res>
    implements $AssessmentSubmitCopyWith<$Res> {
  factory _$$AssessmentSubmitImplCopyWith(_$AssessmentSubmitImpl value,
          $Res Function(_$AssessmentSubmitImpl) then) =
      __$$AssessmentSubmitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AssessmentResponse> responses});
}

/// @nodoc
class __$$AssessmentSubmitImplCopyWithImpl<$Res>
    extends _$AssessmentSubmitCopyWithImpl<$Res, _$AssessmentSubmitImpl>
    implements _$$AssessmentSubmitImplCopyWith<$Res> {
  __$$AssessmentSubmitImplCopyWithImpl(_$AssessmentSubmitImpl _value,
      $Res Function(_$AssessmentSubmitImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssessmentSubmit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responses = null,
  }) {
    return _then(_$AssessmentSubmitImpl(
      responses: null == responses
          ? _value._responses
          : responses // ignore: cast_nullable_to_non_nullable
              as List<AssessmentResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentSubmitImpl implements _AssessmentSubmit {
  const _$AssessmentSubmitImpl(
      {required final List<AssessmentResponse> responses})
      : _responses = responses;

  factory _$AssessmentSubmitImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentSubmitImplFromJson(json);

  final List<AssessmentResponse> _responses;
  @override
  List<AssessmentResponse> get responses {
    if (_responses is EqualUnmodifiableListView) return _responses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_responses);
  }

  @override
  String toString() {
    return 'AssessmentSubmit(responses: $responses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentSubmitImpl &&
            const DeepCollectionEquality()
                .equals(other._responses, _responses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_responses));

  /// Create a copy of AssessmentSubmit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentSubmitImplCopyWith<_$AssessmentSubmitImpl> get copyWith =>
      __$$AssessmentSubmitImplCopyWithImpl<_$AssessmentSubmitImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentSubmitImplToJson(
      this,
    );
  }
}

abstract class _AssessmentSubmit implements AssessmentSubmit {
  const factory _AssessmentSubmit(
          {required final List<AssessmentResponse> responses}) =
      _$AssessmentSubmitImpl;

  factory _AssessmentSubmit.fromJson(Map<String, dynamic> json) =
      _$AssessmentSubmitImpl.fromJson;

  @override
  List<AssessmentResponse> get responses;

  /// Create a copy of AssessmentSubmit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentSubmitImplCopyWith<_$AssessmentSubmitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssessmentResult _$AssessmentResultFromJson(Map<String, dynamic> json) {
  return _AssessmentResult.fromJson(json);
}

/// @nodoc
mixin _$AssessmentResult {
  @JsonKey(name: 'calculated_level')
  double get calculatedLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'responses_count')
  int get responsesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'words_assessed')
  int get wordsAssessed => throw _privateConstructorUsedError;

  /// Serializes this AssessmentResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentResultCopyWith<AssessmentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentResultCopyWith<$Res> {
  factory $AssessmentResultCopyWith(
          AssessmentResult value, $Res Function(AssessmentResult) then) =
      _$AssessmentResultCopyWithImpl<$Res, AssessmentResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'calculated_level') double calculatedLevel,
      @JsonKey(name: 'responses_count') int responsesCount,
      @JsonKey(name: 'words_assessed') int wordsAssessed});
}

/// @nodoc
class _$AssessmentResultCopyWithImpl<$Res, $Val extends AssessmentResult>
    implements $AssessmentResultCopyWith<$Res> {
  _$AssessmentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calculatedLevel = null,
    Object? responsesCount = null,
    Object? wordsAssessed = null,
  }) {
    return _then(_value.copyWith(
      calculatedLevel: null == calculatedLevel
          ? _value.calculatedLevel
          : calculatedLevel // ignore: cast_nullable_to_non_nullable
              as double,
      responsesCount: null == responsesCount
          ? _value.responsesCount
          : responsesCount // ignore: cast_nullable_to_non_nullable
              as int,
      wordsAssessed: null == wordsAssessed
          ? _value.wordsAssessed
          : wordsAssessed // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentResultImplCopyWith<$Res>
    implements $AssessmentResultCopyWith<$Res> {
  factory _$$AssessmentResultImplCopyWith(_$AssessmentResultImpl value,
          $Res Function(_$AssessmentResultImpl) then) =
      __$$AssessmentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'calculated_level') double calculatedLevel,
      @JsonKey(name: 'responses_count') int responsesCount,
      @JsonKey(name: 'words_assessed') int wordsAssessed});
}

/// @nodoc
class __$$AssessmentResultImplCopyWithImpl<$Res>
    extends _$AssessmentResultCopyWithImpl<$Res, _$AssessmentResultImpl>
    implements _$$AssessmentResultImplCopyWith<$Res> {
  __$$AssessmentResultImplCopyWithImpl(_$AssessmentResultImpl _value,
      $Res Function(_$AssessmentResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssessmentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calculatedLevel = null,
    Object? responsesCount = null,
    Object? wordsAssessed = null,
  }) {
    return _then(_$AssessmentResultImpl(
      calculatedLevel: null == calculatedLevel
          ? _value.calculatedLevel
          : calculatedLevel // ignore: cast_nullable_to_non_nullable
              as double,
      responsesCount: null == responsesCount
          ? _value.responsesCount
          : responsesCount // ignore: cast_nullable_to_non_nullable
              as int,
      wordsAssessed: null == wordsAssessed
          ? _value.wordsAssessed
          : wordsAssessed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentResultImpl implements _AssessmentResult {
  const _$AssessmentResultImpl(
      {@JsonKey(name: 'calculated_level') required this.calculatedLevel,
      @JsonKey(name: 'responses_count') required this.responsesCount,
      @JsonKey(name: 'words_assessed') required this.wordsAssessed});

  factory _$AssessmentResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentResultImplFromJson(json);

  @override
  @JsonKey(name: 'calculated_level')
  final double calculatedLevel;
  @override
  @JsonKey(name: 'responses_count')
  final int responsesCount;
  @override
  @JsonKey(name: 'words_assessed')
  final int wordsAssessed;

  @override
  String toString() {
    return 'AssessmentResult(calculatedLevel: $calculatedLevel, responsesCount: $responsesCount, wordsAssessed: $wordsAssessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentResultImpl &&
            (identical(other.calculatedLevel, calculatedLevel) ||
                other.calculatedLevel == calculatedLevel) &&
            (identical(other.responsesCount, responsesCount) ||
                other.responsesCount == responsesCount) &&
            (identical(other.wordsAssessed, wordsAssessed) ||
                other.wordsAssessed == wordsAssessed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, calculatedLevel, responsesCount, wordsAssessed);

  /// Create a copy of AssessmentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentResultImplCopyWith<_$AssessmentResultImpl> get copyWith =>
      __$$AssessmentResultImplCopyWithImpl<_$AssessmentResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentResultImplToJson(
      this,
    );
  }
}

abstract class _AssessmentResult implements AssessmentResult {
  const factory _AssessmentResult(
      {@JsonKey(name: 'calculated_level') required final double calculatedLevel,
      @JsonKey(name: 'responses_count') required final int responsesCount,
      @JsonKey(name: 'words_assessed')
      required final int wordsAssessed}) = _$AssessmentResultImpl;

  factory _AssessmentResult.fromJson(Map<String, dynamic> json) =
      _$AssessmentResultImpl.fromJson;

  @override
  @JsonKey(name: 'calculated_level')
  double get calculatedLevel;
  @override
  @JsonKey(name: 'responses_count')
  int get responsesCount;
  @override
  @JsonKey(name: 'words_assessed')
  int get wordsAssessed;

  /// Create a copy of AssessmentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentResultImplCopyWith<_$AssessmentResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecommendedWord _$RecommendedWordFromJson(Map<String, dynamic> json) {
  return _RecommendedWord.fromJson(json);
}

/// @nodoc
mixin _$RecommendedWord {
  int get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'importance_score')
  int get importanceScore => throw _privateConstructorUsedError;

  /// Serializes this RecommendedWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendedWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendedWordCopyWith<RecommendedWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedWordCopyWith<$Res> {
  factory $RecommendedWordCopyWith(
          RecommendedWord value, $Res Function(RecommendedWord) then) =
      _$RecommendedWordCopyWithImpl<$Res, RecommendedWord>;
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'cefr_level') String? cefrLevel,
      @JsonKey(name: 'category_id') int categoryId,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'importance_score') int importanceScore});
}

/// @nodoc
class _$RecommendedWordCopyWithImpl<$Res, $Val extends RecommendedWord>
    implements $RecommendedWordCopyWith<$Res> {
  _$RecommendedWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendedWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? difficultyLevel = null,
    Object? cefrLevel = freezed,
    Object? categoryId = null,
    Object? categoryName = freezed,
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
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendedWordImplCopyWith<$Res>
    implements $RecommendedWordCopyWith<$Res> {
  factory _$$RecommendedWordImplCopyWith(_$RecommendedWordImpl value,
          $Res Function(_$RecommendedWordImpl) then) =
      __$$RecommendedWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String word,
      String? pronunciation,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'cefr_level') String? cefrLevel,
      @JsonKey(name: 'category_id') int categoryId,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'importance_score') int importanceScore});
}

/// @nodoc
class __$$RecommendedWordImplCopyWithImpl<$Res>
    extends _$RecommendedWordCopyWithImpl<$Res, _$RecommendedWordImpl>
    implements _$$RecommendedWordImplCopyWith<$Res> {
  __$$RecommendedWordImplCopyWithImpl(
      _$RecommendedWordImpl _value, $Res Function(_$RecommendedWordImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendedWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? pronunciation = freezed,
    Object? difficultyLevel = null,
    Object? cefrLevel = freezed,
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? importanceScore = null,
  }) {
    return _then(_$RecommendedWordImpl(
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
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      cefrLevel: freezed == cefrLevel
          ? _value.cefrLevel
          : cefrLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendedWordImpl implements _RecommendedWord {
  const _$RecommendedWordImpl(
      {required this.id,
      required this.word,
      this.pronunciation,
      @JsonKey(name: 'difficulty_level') required this.difficultyLevel,
      @JsonKey(name: 'cefr_level') this.cefrLevel,
      @JsonKey(name: 'category_id') required this.categoryId,
      @JsonKey(name: 'category_name') this.categoryName,
      @JsonKey(name: 'importance_score') required this.importanceScore});

  factory _$RecommendedWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendedWordImplFromJson(json);

  @override
  final int id;
  @override
  final String word;
  @override
  final String? pronunciation;
  @override
  @JsonKey(name: 'difficulty_level')
  final double difficultyLevel;
  @override
  @JsonKey(name: 'cefr_level')
  final String? cefrLevel;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'importance_score')
  final int importanceScore;

  @override
  String toString() {
    return 'RecommendedWord(id: $id, word: $word, pronunciation: $pronunciation, difficultyLevel: $difficultyLevel, cefrLevel: $cefrLevel, categoryId: $categoryId, categoryName: $categoryName, importanceScore: $importanceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendedWordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.cefrLevel, cefrLevel) ||
                other.cefrLevel == cefrLevel) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.importanceScore, importanceScore) ||
                other.importanceScore == importanceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, word, pronunciation,
      difficultyLevel, cefrLevel, categoryId, categoryName, importanceScore);

  /// Create a copy of RecommendedWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendedWordImplCopyWith<_$RecommendedWordImpl> get copyWith =>
      __$$RecommendedWordImplCopyWithImpl<_$RecommendedWordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendedWordImplToJson(
      this,
    );
  }
}

abstract class _RecommendedWord implements RecommendedWord {
  const factory _RecommendedWord(
      {required final int id,
      required final String word,
      final String? pronunciation,
      @JsonKey(name: 'difficulty_level') required final double difficultyLevel,
      @JsonKey(name: 'cefr_level') final String? cefrLevel,
      @JsonKey(name: 'category_id') required final int categoryId,
      @JsonKey(name: 'category_name') final String? categoryName,
      @JsonKey(name: 'importance_score')
      required final int importanceScore}) = _$RecommendedWordImpl;

  factory _RecommendedWord.fromJson(Map<String, dynamic> json) =
      _$RecommendedWordImpl.fromJson;

  @override
  int get id;
  @override
  String get word;
  @override
  String? get pronunciation;
  @override
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel;
  @override
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'importance_score')
  int get importanceScore;

  /// Create a copy of RecommendedWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendedWordImplCopyWith<_$RecommendedWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StackRecommendation _$StackRecommendationFromJson(Map<String, dynamic> json) {
  return _StackRecommendation.fromJson(json);
}

/// @nodoc
mixin _$StackRecommendation {
  List<RecommendedWord> get words => throw _privateConstructorUsedError;
  @JsonKey(name: 'recommended_level')
  double get recommendedLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_current_level')
  double? get userCurrentLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_recommended')
  int get totalRecommended => throw _privateConstructorUsedError;

  /// Serializes this StackRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StackRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StackRecommendationCopyWith<StackRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StackRecommendationCopyWith<$Res> {
  factory $StackRecommendationCopyWith(
          StackRecommendation value, $Res Function(StackRecommendation) then) =
      _$StackRecommendationCopyWithImpl<$Res, StackRecommendation>;
  @useResult
  $Res call(
      {List<RecommendedWord> words,
      @JsonKey(name: 'recommended_level') double recommendedLevel,
      @JsonKey(name: 'user_current_level') double? userCurrentLevel,
      @JsonKey(name: 'total_recommended') int totalRecommended});
}

/// @nodoc
class _$StackRecommendationCopyWithImpl<$Res, $Val extends StackRecommendation>
    implements $StackRecommendationCopyWith<$Res> {
  _$StackRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StackRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? recommendedLevel = null,
    Object? userCurrentLevel = freezed,
    Object? totalRecommended = null,
  }) {
    return _then(_value.copyWith(
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<RecommendedWord>,
      recommendedLevel: null == recommendedLevel
          ? _value.recommendedLevel
          : recommendedLevel // ignore: cast_nullable_to_non_nullable
              as double,
      userCurrentLevel: freezed == userCurrentLevel
          ? _value.userCurrentLevel
          : userCurrentLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRecommended: null == totalRecommended
          ? _value.totalRecommended
          : totalRecommended // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StackRecommendationImplCopyWith<$Res>
    implements $StackRecommendationCopyWith<$Res> {
  factory _$$StackRecommendationImplCopyWith(_$StackRecommendationImpl value,
          $Res Function(_$StackRecommendationImpl) then) =
      __$$StackRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RecommendedWord> words,
      @JsonKey(name: 'recommended_level') double recommendedLevel,
      @JsonKey(name: 'user_current_level') double? userCurrentLevel,
      @JsonKey(name: 'total_recommended') int totalRecommended});
}

/// @nodoc
class __$$StackRecommendationImplCopyWithImpl<$Res>
    extends _$StackRecommendationCopyWithImpl<$Res, _$StackRecommendationImpl>
    implements _$$StackRecommendationImplCopyWith<$Res> {
  __$$StackRecommendationImplCopyWithImpl(_$StackRecommendationImpl _value,
      $Res Function(_$StackRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of StackRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? recommendedLevel = null,
    Object? userCurrentLevel = freezed,
    Object? totalRecommended = null,
  }) {
    return _then(_$StackRecommendationImpl(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<RecommendedWord>,
      recommendedLevel: null == recommendedLevel
          ? _value.recommendedLevel
          : recommendedLevel // ignore: cast_nullable_to_non_nullable
              as double,
      userCurrentLevel: freezed == userCurrentLevel
          ? _value.userCurrentLevel
          : userCurrentLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRecommended: null == totalRecommended
          ? _value.totalRecommended
          : totalRecommended // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StackRecommendationImpl implements _StackRecommendation {
  const _$StackRecommendationImpl(
      {required final List<RecommendedWord> words,
      @JsonKey(name: 'recommended_level') required this.recommendedLevel,
      @JsonKey(name: 'user_current_level') this.userCurrentLevel,
      @JsonKey(name: 'total_recommended') required this.totalRecommended})
      : _words = words;

  factory _$StackRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$StackRecommendationImplFromJson(json);

  final List<RecommendedWord> _words;
  @override
  List<RecommendedWord> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  @JsonKey(name: 'recommended_level')
  final double recommendedLevel;
  @override
  @JsonKey(name: 'user_current_level')
  final double? userCurrentLevel;
  @override
  @JsonKey(name: 'total_recommended')
  final int totalRecommended;

  @override
  String toString() {
    return 'StackRecommendation(words: $words, recommendedLevel: $recommendedLevel, userCurrentLevel: $userCurrentLevel, totalRecommended: $totalRecommended)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StackRecommendationImpl &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.recommendedLevel, recommendedLevel) ||
                other.recommendedLevel == recommendedLevel) &&
            (identical(other.userCurrentLevel, userCurrentLevel) ||
                other.userCurrentLevel == userCurrentLevel) &&
            (identical(other.totalRecommended, totalRecommended) ||
                other.totalRecommended == totalRecommended));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_words),
      recommendedLevel,
      userCurrentLevel,
      totalRecommended);

  /// Create a copy of StackRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StackRecommendationImplCopyWith<_$StackRecommendationImpl> get copyWith =>
      __$$StackRecommendationImplCopyWithImpl<_$StackRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StackRecommendationImplToJson(
      this,
    );
  }
}

abstract class _StackRecommendation implements StackRecommendation {
  const factory _StackRecommendation(
      {required final List<RecommendedWord> words,
      @JsonKey(name: 'recommended_level')
      required final double recommendedLevel,
      @JsonKey(name: 'user_current_level') final double? userCurrentLevel,
      @JsonKey(name: 'total_recommended')
      required final int totalRecommended}) = _$StackRecommendationImpl;

  factory _StackRecommendation.fromJson(Map<String, dynamic> json) =
      _$StackRecommendationImpl.fromJson;

  @override
  List<RecommendedWord> get words;
  @override
  @JsonKey(name: 'recommended_level')
  double get recommendedLevel;
  @override
  @JsonKey(name: 'user_current_level')
  double? get userCurrentLevel;
  @override
  @JsonKey(name: 'total_recommended')
  int get totalRecommended;

  /// Create a copy of StackRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StackRecommendationImplCopyWith<_$StackRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
