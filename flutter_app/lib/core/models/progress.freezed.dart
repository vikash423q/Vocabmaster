// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyStackItem _$DailyStackItemFromJson(Map<String, dynamic> json) {
  return _DailyStackItem.fromJson(json);
}

/// @nodoc
mixin _$DailyStackItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_date')
  String get scheduledDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_reviewed')
  bool get isReviewed => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;

  /// Serializes this DailyStackItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyStackItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyStackItemCopyWith<DailyStackItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStackItemCopyWith<$Res> {
  factory $DailyStackItemCopyWith(
          DailyStackItem value, $Res Function(DailyStackItem) then) =
      _$DailyStackItemCopyWithImpl<$Res, DailyStackItem>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'word_id') int wordId,
      String word,
      @JsonKey(name: 'scheduled_date') String scheduledDate,
      @JsonKey(name: 'is_reviewed') bool isReviewed,
      int level});
}

/// @nodoc
class _$DailyStackItemCopyWithImpl<$Res, $Val extends DailyStackItem>
    implements $DailyStackItemCopyWith<$Res> {
  _$DailyStackItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyStackItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wordId = null,
    Object? word = null,
    Object? scheduledDate = null,
    Object? isReviewed = null,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: null == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as String,
      isReviewed: null == isReviewed
          ? _value.isReviewed
          : isReviewed // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyStackItemImplCopyWith<$Res>
    implements $DailyStackItemCopyWith<$Res> {
  factory _$$DailyStackItemImplCopyWith(_$DailyStackItemImpl value,
          $Res Function(_$DailyStackItemImpl) then) =
      __$$DailyStackItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'word_id') int wordId,
      String word,
      @JsonKey(name: 'scheduled_date') String scheduledDate,
      @JsonKey(name: 'is_reviewed') bool isReviewed,
      int level});
}

/// @nodoc
class __$$DailyStackItemImplCopyWithImpl<$Res>
    extends _$DailyStackItemCopyWithImpl<$Res, _$DailyStackItemImpl>
    implements _$$DailyStackItemImplCopyWith<$Res> {
  __$$DailyStackItemImplCopyWithImpl(
      _$DailyStackItemImpl _value, $Res Function(_$DailyStackItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyStackItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wordId = null,
    Object? word = null,
    Object? scheduledDate = null,
    Object? isReviewed = null,
    Object? level = null,
  }) {
    return _then(_$DailyStackItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: null == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as String,
      isReviewed: null == isReviewed
          ? _value.isReviewed
          : isReviewed // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStackItemImpl implements _DailyStackItem {
  const _$DailyStackItemImpl(
      {required this.id,
      @JsonKey(name: 'word_id') required this.wordId,
      required this.word,
      @JsonKey(name: 'scheduled_date') required this.scheduledDate,
      @JsonKey(name: 'is_reviewed') required this.isReviewed,
      this.level = 0});

  factory _$DailyStackItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStackItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String word;
  @override
  @JsonKey(name: 'scheduled_date')
  final String scheduledDate;
  @override
  @JsonKey(name: 'is_reviewed')
  final bool isReviewed;
  @override
  @JsonKey()
  final int level;

  @override
  String toString() {
    return 'DailyStackItem(id: $id, wordId: $wordId, word: $word, scheduledDate: $scheduledDate, isReviewed: $isReviewed, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStackItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.isReviewed, isReviewed) ||
                other.isReviewed == isReviewed) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, wordId, word, scheduledDate, isReviewed, level);

  /// Create a copy of DailyStackItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStackItemImplCopyWith<_$DailyStackItemImpl> get copyWith =>
      __$$DailyStackItemImplCopyWithImpl<_$DailyStackItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStackItemImplToJson(
      this,
    );
  }
}

abstract class _DailyStackItem implements DailyStackItem {
  const factory _DailyStackItem(
      {required final int id,
      @JsonKey(name: 'word_id') required final int wordId,
      required final String word,
      @JsonKey(name: 'scheduled_date') required final String scheduledDate,
      @JsonKey(name: 'is_reviewed') required final bool isReviewed,
      final int level}) = _$DailyStackItemImpl;

  factory _DailyStackItem.fromJson(Map<String, dynamic> json) =
      _$DailyStackItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String get word;
  @override
  @JsonKey(name: 'scheduled_date')
  String get scheduledDate;
  @override
  @JsonKey(name: 'is_reviewed')
  bool get isReviewed;
  @override
  int get level;

  /// Create a copy of DailyStackItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyStackItemImplCopyWith<_$DailyStackItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddWordsRequest _$AddWordsRequestFromJson(Map<String, dynamic> json) {
  return _AddWordsRequest.fromJson(json);
}

/// @nodoc
mixin _$AddWordsRequest {
  @JsonKey(name: 'word_ids')
  List<int> get wordIds => throw _privateConstructorUsedError;

  /// Serializes this AddWordsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddWordsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddWordsRequestCopyWith<AddWordsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddWordsRequestCopyWith<$Res> {
  factory $AddWordsRequestCopyWith(
          AddWordsRequest value, $Res Function(AddWordsRequest) then) =
      _$AddWordsRequestCopyWithImpl<$Res, AddWordsRequest>;
  @useResult
  $Res call({@JsonKey(name: 'word_ids') List<int> wordIds});
}

/// @nodoc
class _$AddWordsRequestCopyWithImpl<$Res, $Val extends AddWordsRequest>
    implements $AddWordsRequestCopyWith<$Res> {
  _$AddWordsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddWordsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordIds = null,
  }) {
    return _then(_value.copyWith(
      wordIds: null == wordIds
          ? _value.wordIds
          : wordIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddWordsRequestImplCopyWith<$Res>
    implements $AddWordsRequestCopyWith<$Res> {
  factory _$$AddWordsRequestImplCopyWith(_$AddWordsRequestImpl value,
          $Res Function(_$AddWordsRequestImpl) then) =
      __$$AddWordsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'word_ids') List<int> wordIds});
}

/// @nodoc
class __$$AddWordsRequestImplCopyWithImpl<$Res>
    extends _$AddWordsRequestCopyWithImpl<$Res, _$AddWordsRequestImpl>
    implements _$$AddWordsRequestImplCopyWith<$Res> {
  __$$AddWordsRequestImplCopyWithImpl(
      _$AddWordsRequestImpl _value, $Res Function(_$AddWordsRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddWordsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordIds = null,
  }) {
    return _then(_$AddWordsRequestImpl(
      wordIds: null == wordIds
          ? _value._wordIds
          : wordIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddWordsRequestImpl implements _AddWordsRequest {
  const _$AddWordsRequestImpl(
      {@JsonKey(name: 'word_ids') required final List<int> wordIds})
      : _wordIds = wordIds;

  factory _$AddWordsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddWordsRequestImplFromJson(json);

  final List<int> _wordIds;
  @override
  @JsonKey(name: 'word_ids')
  List<int> get wordIds {
    if (_wordIds is EqualUnmodifiableListView) return _wordIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wordIds);
  }

  @override
  String toString() {
    return 'AddWordsRequest(wordIds: $wordIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddWordsRequestImpl &&
            const DeepCollectionEquality().equals(other._wordIds, _wordIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_wordIds));

  /// Create a copy of AddWordsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddWordsRequestImplCopyWith<_$AddWordsRequestImpl> get copyWith =>
      __$$AddWordsRequestImplCopyWithImpl<_$AddWordsRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddWordsRequestImplToJson(
      this,
    );
  }
}

abstract class _AddWordsRequest implements AddWordsRequest {
  const factory _AddWordsRequest(
          {@JsonKey(name: 'word_ids') required final List<int> wordIds}) =
      _$AddWordsRequestImpl;

  factory _AddWordsRequest.fromJson(Map<String, dynamic> json) =
      _$AddWordsRequestImpl.fromJson;

  @override
  @JsonKey(name: 'word_ids')
  List<int> get wordIds;

  /// Create a copy of AddWordsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddWordsRequestImplCopyWith<_$AddWordsRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddWordsResponse _$AddWordsResponseFromJson(Map<String, dynamic> json) {
  return _AddWordsResponse.fromJson(json);
}

/// @nodoc
mixin _$AddWordsResponse {
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_count')
  int get addedCount => throw _privateConstructorUsedError;

  /// Serializes this AddWordsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddWordsResponseCopyWith<AddWordsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddWordsResponseCopyWith<$Res> {
  factory $AddWordsResponseCopyWith(
          AddWordsResponse value, $Res Function(AddWordsResponse) then) =
      _$AddWordsResponseCopyWithImpl<$Res, AddWordsResponse>;
  @useResult
  $Res call({String message, @JsonKey(name: 'added_count') int addedCount});
}

/// @nodoc
class _$AddWordsResponseCopyWithImpl<$Res, $Val extends AddWordsResponse>
    implements $AddWordsResponseCopyWith<$Res> {
  _$AddWordsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? addedCount = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      addedCount: null == addedCount
          ? _value.addedCount
          : addedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddWordsResponseImplCopyWith<$Res>
    implements $AddWordsResponseCopyWith<$Res> {
  factory _$$AddWordsResponseImplCopyWith(_$AddWordsResponseImpl value,
          $Res Function(_$AddWordsResponseImpl) then) =
      __$$AddWordsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, @JsonKey(name: 'added_count') int addedCount});
}

/// @nodoc
class __$$AddWordsResponseImplCopyWithImpl<$Res>
    extends _$AddWordsResponseCopyWithImpl<$Res, _$AddWordsResponseImpl>
    implements _$$AddWordsResponseImplCopyWith<$Res> {
  __$$AddWordsResponseImplCopyWithImpl(_$AddWordsResponseImpl _value,
      $Res Function(_$AddWordsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? addedCount = null,
  }) {
    return _then(_$AddWordsResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      addedCount: null == addedCount
          ? _value.addedCount
          : addedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddWordsResponseImpl implements _AddWordsResponse {
  const _$AddWordsResponseImpl(
      {required this.message,
      @JsonKey(name: 'added_count') required this.addedCount});

  factory _$AddWordsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddWordsResponseImplFromJson(json);

  @override
  final String message;
  @override
  @JsonKey(name: 'added_count')
  final int addedCount;

  @override
  String toString() {
    return 'AddWordsResponse(message: $message, addedCount: $addedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddWordsResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.addedCount, addedCount) ||
                other.addedCount == addedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, addedCount);

  /// Create a copy of AddWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddWordsResponseImplCopyWith<_$AddWordsResponseImpl> get copyWith =>
      __$$AddWordsResponseImplCopyWithImpl<_$AddWordsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddWordsResponseImplToJson(
      this,
    );
  }
}

abstract class _AddWordsResponse implements AddWordsResponse {
  const factory _AddWordsResponse(
          {required final String message,
          @JsonKey(name: 'added_count') required final int addedCount}) =
      _$AddWordsResponseImpl;

  factory _AddWordsResponse.fromJson(Map<String, dynamic> json) =
      _$AddWordsResponseImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(name: 'added_count')
  int get addedCount;

  /// Create a copy of AddWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddWordsResponseImplCopyWith<_$AddWordsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewSubmit _$ReviewSubmitFromJson(Map<String, dynamic> json) {
  return _ReviewSubmit.fromJson(json);
}

/// @nodoc
mixin _$ReviewSubmit {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_correct')
  bool get isCorrect => throw _privateConstructorUsedError;
  @JsonKey(name: 'question_type')
  String get questionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_answer')
  String? get userAnswer => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answer')
  String get correctAnswer => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_taken_seconds')
  int? get timeTakenSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'options_presented')
  List<String>? get optionsPresented => throw _privateConstructorUsedError;

  /// Serializes this ReviewSubmit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewSubmit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewSubmitCopyWith<ReviewSubmit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewSubmitCopyWith<$Res> {
  factory $ReviewSubmitCopyWith(
          ReviewSubmit value, $Res Function(ReviewSubmit) then) =
      _$ReviewSubmitCopyWithImpl<$Res, ReviewSubmit>;
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      @JsonKey(name: 'question_type') String questionType,
      @JsonKey(name: 'user_answer') String? userAnswer,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      @JsonKey(name: 'time_taken_seconds') int? timeTakenSeconds,
      @JsonKey(name: 'options_presented') List<String>? optionsPresented});
}

/// @nodoc
class _$ReviewSubmitCopyWithImpl<$Res, $Val extends ReviewSubmit>
    implements $ReviewSubmitCopyWith<$Res> {
  _$ReviewSubmitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewSubmit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? isCorrect = null,
    Object? questionType = null,
    Object? userAnswer = freezed,
    Object? correctAnswer = null,
    Object? timeTakenSeconds = freezed,
    Object? optionsPresented = freezed,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as String,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      timeTakenSeconds: freezed == timeTakenSeconds
          ? _value.timeTakenSeconds
          : timeTakenSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      optionsPresented: freezed == optionsPresented
          ? _value.optionsPresented
          : optionsPresented // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewSubmitImplCopyWith<$Res>
    implements $ReviewSubmitCopyWith<$Res> {
  factory _$$ReviewSubmitImplCopyWith(
          _$ReviewSubmitImpl value, $Res Function(_$ReviewSubmitImpl) then) =
      __$$ReviewSubmitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      @JsonKey(name: 'question_type') String questionType,
      @JsonKey(name: 'user_answer') String? userAnswer,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      @JsonKey(name: 'time_taken_seconds') int? timeTakenSeconds,
      @JsonKey(name: 'options_presented') List<String>? optionsPresented});
}

/// @nodoc
class __$$ReviewSubmitImplCopyWithImpl<$Res>
    extends _$ReviewSubmitCopyWithImpl<$Res, _$ReviewSubmitImpl>
    implements _$$ReviewSubmitImplCopyWith<$Res> {
  __$$ReviewSubmitImplCopyWithImpl(
      _$ReviewSubmitImpl _value, $Res Function(_$ReviewSubmitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewSubmit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? isCorrect = null,
    Object? questionType = null,
    Object? userAnswer = freezed,
    Object? correctAnswer = null,
    Object? timeTakenSeconds = freezed,
    Object? optionsPresented = freezed,
  }) {
    return _then(_$ReviewSubmitImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as String,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      timeTakenSeconds: freezed == timeTakenSeconds
          ? _value.timeTakenSeconds
          : timeTakenSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      optionsPresented: freezed == optionsPresented
          ? _value._optionsPresented
          : optionsPresented // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewSubmitImpl implements _ReviewSubmit {
  const _$ReviewSubmitImpl(
      {@JsonKey(name: 'word_id') required this.wordId,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      @JsonKey(name: 'question_type') required this.questionType,
      @JsonKey(name: 'user_answer') this.userAnswer,
      @JsonKey(name: 'correct_answer') required this.correctAnswer,
      @JsonKey(name: 'time_taken_seconds') this.timeTakenSeconds,
      @JsonKey(name: 'options_presented') final List<String>? optionsPresented})
      : _optionsPresented = optionsPresented;

  factory _$ReviewSubmitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewSubmitImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  @JsonKey(name: 'question_type')
  final String questionType;
  @override
  @JsonKey(name: 'user_answer')
  final String? userAnswer;
  @override
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  @override
  @JsonKey(name: 'time_taken_seconds')
  final int? timeTakenSeconds;
  final List<String>? _optionsPresented;
  @override
  @JsonKey(name: 'options_presented')
  List<String>? get optionsPresented {
    final value = _optionsPresented;
    if (value == null) return null;
    if (_optionsPresented is EqualUnmodifiableListView)
      return _optionsPresented;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ReviewSubmit(wordId: $wordId, isCorrect: $isCorrect, questionType: $questionType, userAnswer: $userAnswer, correctAnswer: $correctAnswer, timeTakenSeconds: $timeTakenSeconds, optionsPresented: $optionsPresented)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewSubmitImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.timeTakenSeconds, timeTakenSeconds) ||
                other.timeTakenSeconds == timeTakenSeconds) &&
            const DeepCollectionEquality()
                .equals(other._optionsPresented, _optionsPresented));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      wordId,
      isCorrect,
      questionType,
      userAnswer,
      correctAnswer,
      timeTakenSeconds,
      const DeepCollectionEquality().hash(_optionsPresented));

  /// Create a copy of ReviewSubmit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewSubmitImplCopyWith<_$ReviewSubmitImpl> get copyWith =>
      __$$ReviewSubmitImplCopyWithImpl<_$ReviewSubmitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewSubmitImplToJson(
      this,
    );
  }
}

abstract class _ReviewSubmit implements ReviewSubmit {
  const factory _ReviewSubmit(
      {@JsonKey(name: 'word_id') required final int wordId,
      @JsonKey(name: 'is_correct') required final bool isCorrect,
      @JsonKey(name: 'question_type') required final String questionType,
      @JsonKey(name: 'user_answer') final String? userAnswer,
      @JsonKey(name: 'correct_answer') required final String correctAnswer,
      @JsonKey(name: 'time_taken_seconds') final int? timeTakenSeconds,
      @JsonKey(name: 'options_presented')
      final List<String>? optionsPresented}) = _$ReviewSubmitImpl;

  factory _ReviewSubmit.fromJson(Map<String, dynamic> json) =
      _$ReviewSubmitImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  @override
  @JsonKey(name: 'question_type')
  String get questionType;
  @override
  @JsonKey(name: 'user_answer')
  String? get userAnswer;
  @override
  @JsonKey(name: 'correct_answer')
  String get correctAnswer;
  @override
  @JsonKey(name: 'time_taken_seconds')
  int? get timeTakenSeconds;
  @override
  @JsonKey(name: 'options_presented')
  List<String>? get optionsPresented;

  /// Create a copy of ReviewSubmit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewSubmitImplCopyWith<_$ReviewSubmitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) {
  return _ReviewResponse.fromJson(json);
}

/// @nodoc
mixin _$ReviewResponse {
  bool get success => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_level')
  int get newLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_review_date')
  String? get nextReviewDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ReviewResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewResponseCopyWith<ReviewResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewResponseCopyWith<$Res> {
  factory $ReviewResponseCopyWith(
          ReviewResponse value, $Res Function(ReviewResponse) then) =
      _$ReviewResponseCopyWithImpl<$Res, ReviewResponse>;
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'new_level') int newLevel,
      @JsonKey(name: 'next_review_date') String? nextReviewDate,
      String status,
      String message});
}

/// @nodoc
class _$ReviewResponseCopyWithImpl<$Res, $Val extends ReviewResponse>
    implements $ReviewResponseCopyWith<$Res> {
  _$ReviewResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? newLevel = null,
    Object? nextReviewDate = freezed,
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      newLevel: null == newLevel
          ? _value.newLevel
          : newLevel // ignore: cast_nullable_to_non_nullable
              as int,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewResponseImplCopyWith<$Res>
    implements $ReviewResponseCopyWith<$Res> {
  factory _$$ReviewResponseImplCopyWith(_$ReviewResponseImpl value,
          $Res Function(_$ReviewResponseImpl) then) =
      __$$ReviewResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'new_level') int newLevel,
      @JsonKey(name: 'next_review_date') String? nextReviewDate,
      String status,
      String message});
}

/// @nodoc
class __$$ReviewResponseImplCopyWithImpl<$Res>
    extends _$ReviewResponseCopyWithImpl<$Res, _$ReviewResponseImpl>
    implements _$$ReviewResponseImplCopyWith<$Res> {
  __$$ReviewResponseImplCopyWithImpl(
      _$ReviewResponseImpl _value, $Res Function(_$ReviewResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? newLevel = null,
    Object? nextReviewDate = freezed,
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$ReviewResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      newLevel: null == newLevel
          ? _value.newLevel
          : newLevel // ignore: cast_nullable_to_non_nullable
              as int,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewResponseImpl implements _ReviewResponse {
  const _$ReviewResponseImpl(
      {required this.success,
      @JsonKey(name: 'new_level') required this.newLevel,
      @JsonKey(name: 'next_review_date') this.nextReviewDate,
      required this.status,
      required this.message});

  factory _$ReviewResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewResponseImplFromJson(json);

  @override
  final bool success;
  @override
  @JsonKey(name: 'new_level')
  final int newLevel;
  @override
  @JsonKey(name: 'next_review_date')
  final String? nextReviewDate;
  @override
  final String status;
  @override
  final String message;

  @override
  String toString() {
    return 'ReviewResponse(success: $success, newLevel: $newLevel, nextReviewDate: $nextReviewDate, status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.newLevel, newLevel) ||
                other.newLevel == newLevel) &&
            (identical(other.nextReviewDate, nextReviewDate) ||
                other.nextReviewDate == nextReviewDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, newLevel, nextReviewDate, status, message);

  /// Create a copy of ReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewResponseImplCopyWith<_$ReviewResponseImpl> get copyWith =>
      __$$ReviewResponseImplCopyWithImpl<_$ReviewResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewResponseImplToJson(
      this,
    );
  }
}

abstract class _ReviewResponse implements ReviewResponse {
  const factory _ReviewResponse(
      {required final bool success,
      @JsonKey(name: 'new_level') required final int newLevel,
      @JsonKey(name: 'next_review_date') final String? nextReviewDate,
      required final String status,
      required final String message}) = _$ReviewResponseImpl;

  factory _ReviewResponse.fromJson(Map<String, dynamic> json) =
      _$ReviewResponseImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(name: 'new_level')
  int get newLevel;
  @override
  @JsonKey(name: 'next_review_date')
  String? get nextReviewDate;
  @override
  String get status;
  @override
  String get message;

  /// Create a copy of ReviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewResponseImplCopyWith<_$ReviewResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WordProgressDetail _$WordProgressDetailFromJson(Map<String, dynamic> json) {
  return _WordProgressDetail.fromJson(json);
}

/// @nodoc
mixin _$WordProgressDetail {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String? get word => throw _privateConstructorUsedError;
  @JsonKey(name: 'fibonacci_level')
  int get fibonacciLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_review_date')
  String? get nextReviewDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_count')
  int get correctCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'incorrect_count')
  int get incorrectCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_reviewed_at')
  String? get lastReviewedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_at')
  String? get addedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'mastered_at')
  String? get masteredAt => throw _privateConstructorUsedError;

  /// Serializes this WordProgressDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordProgressDetailCopyWith<WordProgressDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordProgressDetailCopyWith<$Res> {
  factory $WordProgressDetailCopyWith(
          WordProgressDetail value, $Res Function(WordProgressDetail) then) =
      _$WordProgressDetailCopyWithImpl<$Res, WordProgressDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      String? word,
      @JsonKey(name: 'fibonacci_level') int fibonacciLevel,
      @JsonKey(name: 'next_review_date') String? nextReviewDate,
      @JsonKey(name: 'correct_count') int correctCount,
      @JsonKey(name: 'incorrect_count') int incorrectCount,
      @JsonKey(name: 'last_reviewed_at') String? lastReviewedAt,
      String status,
      @JsonKey(name: 'added_at') String? addedAt,
      @JsonKey(name: 'mastered_at') String? masteredAt});
}

/// @nodoc
class _$WordProgressDetailCopyWithImpl<$Res, $Val extends WordProgressDetail>
    implements $WordProgressDetailCopyWith<$Res> {
  _$WordProgressDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = freezed,
    Object? fibonacciLevel = null,
    Object? nextReviewDate = freezed,
    Object? correctCount = null,
    Object? incorrectCount = null,
    Object? lastReviewedAt = freezed,
    Object? status = null,
    Object? addedAt = freezed,
    Object? masteredAt = freezed,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: freezed == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String?,
      fibonacciLevel: null == fibonacciLevel
          ? _value.fibonacciLevel
          : fibonacciLevel // ignore: cast_nullable_to_non_nullable
              as int,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      correctCount: null == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastReviewedAt: freezed == lastReviewedAt
          ? _value.lastReviewedAt
          : lastReviewedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      masteredAt: freezed == masteredAt
          ? _value.masteredAt
          : masteredAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordProgressDetailImplCopyWith<$Res>
    implements $WordProgressDetailCopyWith<$Res> {
  factory _$$WordProgressDetailImplCopyWith(_$WordProgressDetailImpl value,
          $Res Function(_$WordProgressDetailImpl) then) =
      __$$WordProgressDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      String? word,
      @JsonKey(name: 'fibonacci_level') int fibonacciLevel,
      @JsonKey(name: 'next_review_date') String? nextReviewDate,
      @JsonKey(name: 'correct_count') int correctCount,
      @JsonKey(name: 'incorrect_count') int incorrectCount,
      @JsonKey(name: 'last_reviewed_at') String? lastReviewedAt,
      String status,
      @JsonKey(name: 'added_at') String? addedAt,
      @JsonKey(name: 'mastered_at') String? masteredAt});
}

/// @nodoc
class __$$WordProgressDetailImplCopyWithImpl<$Res>
    extends _$WordProgressDetailCopyWithImpl<$Res, _$WordProgressDetailImpl>
    implements _$$WordProgressDetailImplCopyWith<$Res> {
  __$$WordProgressDetailImplCopyWithImpl(_$WordProgressDetailImpl _value,
      $Res Function(_$WordProgressDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = freezed,
    Object? fibonacciLevel = null,
    Object? nextReviewDate = freezed,
    Object? correctCount = null,
    Object? incorrectCount = null,
    Object? lastReviewedAt = freezed,
    Object? status = null,
    Object? addedAt = freezed,
    Object? masteredAt = freezed,
  }) {
    return _then(_$WordProgressDetailImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: freezed == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String?,
      fibonacciLevel: null == fibonacciLevel
          ? _value.fibonacciLevel
          : fibonacciLevel // ignore: cast_nullable_to_non_nullable
              as int,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      correctCount: null == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastReviewedAt: freezed == lastReviewedAt
          ? _value.lastReviewedAt
          : lastReviewedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      masteredAt: freezed == masteredAt
          ? _value.masteredAt
          : masteredAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordProgressDetailImpl implements _WordProgressDetail {
  const _$WordProgressDetailImpl(
      {@JsonKey(name: 'word_id') required this.wordId,
      this.word,
      @JsonKey(name: 'fibonacci_level') required this.fibonacciLevel,
      @JsonKey(name: 'next_review_date') this.nextReviewDate,
      @JsonKey(name: 'correct_count') required this.correctCount,
      @JsonKey(name: 'incorrect_count') required this.incorrectCount,
      @JsonKey(name: 'last_reviewed_at') this.lastReviewedAt,
      required this.status,
      @JsonKey(name: 'added_at') this.addedAt,
      @JsonKey(name: 'mastered_at') this.masteredAt});

  factory _$WordProgressDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordProgressDetailImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String? word;
  @override
  @JsonKey(name: 'fibonacci_level')
  final int fibonacciLevel;
  @override
  @JsonKey(name: 'next_review_date')
  final String? nextReviewDate;
  @override
  @JsonKey(name: 'correct_count')
  final int correctCount;
  @override
  @JsonKey(name: 'incorrect_count')
  final int incorrectCount;
  @override
  @JsonKey(name: 'last_reviewed_at')
  final String? lastReviewedAt;
  @override
  final String status;
  @override
  @JsonKey(name: 'added_at')
  final String? addedAt;
  @override
  @JsonKey(name: 'mastered_at')
  final String? masteredAt;

  @override
  String toString() {
    return 'WordProgressDetail(wordId: $wordId, word: $word, fibonacciLevel: $fibonacciLevel, nextReviewDate: $nextReviewDate, correctCount: $correctCount, incorrectCount: $incorrectCount, lastReviewedAt: $lastReviewedAt, status: $status, addedAt: $addedAt, masteredAt: $masteredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordProgressDetailImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.fibonacciLevel, fibonacciLevel) ||
                other.fibonacciLevel == fibonacciLevel) &&
            (identical(other.nextReviewDate, nextReviewDate) ||
                other.nextReviewDate == nextReviewDate) &&
            (identical(other.correctCount, correctCount) ||
                other.correctCount == correctCount) &&
            (identical(other.incorrectCount, incorrectCount) ||
                other.incorrectCount == incorrectCount) &&
            (identical(other.lastReviewedAt, lastReviewedAt) ||
                other.lastReviewedAt == lastReviewedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.masteredAt, masteredAt) ||
                other.masteredAt == masteredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      wordId,
      word,
      fibonacciLevel,
      nextReviewDate,
      correctCount,
      incorrectCount,
      lastReviewedAt,
      status,
      addedAt,
      masteredAt);

  /// Create a copy of WordProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordProgressDetailImplCopyWith<_$WordProgressDetailImpl> get copyWith =>
      __$$WordProgressDetailImplCopyWithImpl<_$WordProgressDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordProgressDetailImplToJson(
      this,
    );
  }
}

abstract class _WordProgressDetail implements WordProgressDetail {
  const factory _WordProgressDetail(
          {@JsonKey(name: 'word_id') required final int wordId,
          final String? word,
          @JsonKey(name: 'fibonacci_level') required final int fibonacciLevel,
          @JsonKey(name: 'next_review_date') final String? nextReviewDate,
          @JsonKey(name: 'correct_count') required final int correctCount,
          @JsonKey(name: 'incorrect_count') required final int incorrectCount,
          @JsonKey(name: 'last_reviewed_at') final String? lastReviewedAt,
          required final String status,
          @JsonKey(name: 'added_at') final String? addedAt,
          @JsonKey(name: 'mastered_at') final String? masteredAt}) =
      _$WordProgressDetailImpl;

  factory _WordProgressDetail.fromJson(Map<String, dynamic> json) =
      _$WordProgressDetailImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String? get word;
  @override
  @JsonKey(name: 'fibonacci_level')
  int get fibonacciLevel;
  @override
  @JsonKey(name: 'next_review_date')
  String? get nextReviewDate;
  @override
  @JsonKey(name: 'correct_count')
  int get correctCount;
  @override
  @JsonKey(name: 'incorrect_count')
  int get incorrectCount;
  @override
  @JsonKey(name: 'last_reviewed_at')
  String? get lastReviewedAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'added_at')
  String? get addedAt;
  @override
  @JsonKey(name: 'mastered_at')
  String? get masteredAt;

  /// Create a copy of WordProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordProgressDetailImplCopyWith<_$WordProgressDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpcomingReview _$UpcomingReviewFromJson(Map<String, dynamic> json) {
  return _UpcomingReview.fromJson(json);
}

/// @nodoc
mixin _$UpcomingReview {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String? get word => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_date')
  String? get reviewDate => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;

  /// Serializes this UpcomingReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpcomingReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpcomingReviewCopyWith<UpcomingReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpcomingReviewCopyWith<$Res> {
  factory $UpcomingReviewCopyWith(
          UpcomingReview value, $Res Function(UpcomingReview) then) =
      _$UpcomingReviewCopyWithImpl<$Res, UpcomingReview>;
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      String? word,
      @JsonKey(name: 'review_date') String? reviewDate,
      int level});
}

/// @nodoc
class _$UpcomingReviewCopyWithImpl<$Res, $Val extends UpcomingReview>
    implements $UpcomingReviewCopyWith<$Res> {
  _$UpcomingReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpcomingReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = freezed,
    Object? reviewDate = freezed,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: freezed == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewDate: freezed == reviewDate
          ? _value.reviewDate
          : reviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpcomingReviewImplCopyWith<$Res>
    implements $UpcomingReviewCopyWith<$Res> {
  factory _$$UpcomingReviewImplCopyWith(_$UpcomingReviewImpl value,
          $Res Function(_$UpcomingReviewImpl) then) =
      __$$UpcomingReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      String? word,
      @JsonKey(name: 'review_date') String? reviewDate,
      int level});
}

/// @nodoc
class __$$UpcomingReviewImplCopyWithImpl<$Res>
    extends _$UpcomingReviewCopyWithImpl<$Res, _$UpcomingReviewImpl>
    implements _$$UpcomingReviewImplCopyWith<$Res> {
  __$$UpcomingReviewImplCopyWithImpl(
      _$UpcomingReviewImpl _value, $Res Function(_$UpcomingReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpcomingReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = freezed,
    Object? reviewDate = freezed,
    Object? level = null,
  }) {
    return _then(_$UpcomingReviewImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: freezed == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewDate: freezed == reviewDate
          ? _value.reviewDate
          : reviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpcomingReviewImpl implements _UpcomingReview {
  const _$UpcomingReviewImpl(
      {@JsonKey(name: 'word_id') required this.wordId,
      this.word,
      @JsonKey(name: 'review_date') this.reviewDate,
      required this.level});

  factory _$UpcomingReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpcomingReviewImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String? word;
  @override
  @JsonKey(name: 'review_date')
  final String? reviewDate;
  @override
  final int level;

  @override
  String toString() {
    return 'UpcomingReview(wordId: $wordId, word: $word, reviewDate: $reviewDate, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpcomingReviewImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.reviewDate, reviewDate) ||
                other.reviewDate == reviewDate) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wordId, word, reviewDate, level);

  /// Create a copy of UpcomingReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpcomingReviewImplCopyWith<_$UpcomingReviewImpl> get copyWith =>
      __$$UpcomingReviewImplCopyWithImpl<_$UpcomingReviewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpcomingReviewImplToJson(
      this,
    );
  }
}

abstract class _UpcomingReview implements UpcomingReview {
  const factory _UpcomingReview(
      {@JsonKey(name: 'word_id') required final int wordId,
      final String? word,
      @JsonKey(name: 'review_date') final String? reviewDate,
      required final int level}) = _$UpcomingReviewImpl;

  factory _UpcomingReview.fromJson(Map<String, dynamic> json) =
      _$UpcomingReviewImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String? get word;
  @override
  @JsonKey(name: 'review_date')
  String? get reviewDate;
  @override
  int get level;

  /// Create a copy of UpcomingReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpcomingReviewImplCopyWith<_$UpcomingReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressWord _$ProgressWordFromJson(Map<String, dynamic> json) {
  return _ProgressWord.fromJson(json);
}

/// @nodoc
mixin _$ProgressWord {
  int get id => throw _privateConstructorUsedError;
  String? get word => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'importance_score')
  int get importanceScore => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'fibonacci_level')
  int get fibonacciLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_review_date')
  String? get nextReviewDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_count')
  int get correctCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'incorrect_count')
  int get incorrectCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_reviewed_at')
  String? get lastReviewedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'added_at')
  String? get addedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'mastered_at')
  String? get masteredAt => throw _privateConstructorUsedError;
  String? get tone => throw _privateConstructorUsedError;
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel => throw _privateConstructorUsedError;

  /// Serializes this ProgressWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressWordCopyWith<ProgressWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressWordCopyWith<$Res> {
  factory $ProgressWordCopyWith(
          ProgressWord value, $Res Function(ProgressWord) then) =
      _$ProgressWordCopyWithImpl<$Res, ProgressWord>;
  @useResult
  $Res call(
      {int id,
      String? word,
      String? pronunciation,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'importance_score') int importanceScore,
      String status,
      @JsonKey(name: 'fibonacci_level') int fibonacciLevel,
      @JsonKey(name: 'next_review_date') String? nextReviewDate,
      @JsonKey(name: 'correct_count') int correctCount,
      @JsonKey(name: 'incorrect_count') int incorrectCount,
      @JsonKey(name: 'last_reviewed_at') String? lastReviewedAt,
      @JsonKey(name: 'added_at') String? addedAt,
      @JsonKey(name: 'mastered_at') String? masteredAt,
      String? tone,
      @JsonKey(name: 'cefr_level') String? cefrLevel});
}

/// @nodoc
class _$ProgressWordCopyWithImpl<$Res, $Val extends ProgressWord>
    implements $ProgressWordCopyWith<$Res> {
  _$ProgressWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = freezed,
    Object? pronunciation = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
    Object? status = null,
    Object? fibonacciLevel = null,
    Object? nextReviewDate = freezed,
    Object? correctCount = null,
    Object? incorrectCount = null,
    Object? lastReviewedAt = freezed,
    Object? addedAt = freezed,
    Object? masteredAt = freezed,
    Object? tone = freezed,
    Object? cefrLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      word: freezed == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String?,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fibonacciLevel: null == fibonacciLevel
          ? _value.fibonacciLevel
          : fibonacciLevel // ignore: cast_nullable_to_non_nullable
              as int,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      correctCount: null == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastReviewedAt: freezed == lastReviewedAt
          ? _value.lastReviewedAt
          : lastReviewedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      masteredAt: freezed == masteredAt
          ? _value.masteredAt
          : masteredAt // ignore: cast_nullable_to_non_nullable
              as String?,
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
}

/// @nodoc
abstract class _$$ProgressWordImplCopyWith<$Res>
    implements $ProgressWordCopyWith<$Res> {
  factory _$$ProgressWordImplCopyWith(
          _$ProgressWordImpl value, $Res Function(_$ProgressWordImpl) then) =
      __$$ProgressWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? word,
      String? pronunciation,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'difficulty_level') double difficultyLevel,
      @JsonKey(name: 'importance_score') int importanceScore,
      String status,
      @JsonKey(name: 'fibonacci_level') int fibonacciLevel,
      @JsonKey(name: 'next_review_date') String? nextReviewDate,
      @JsonKey(name: 'correct_count') int correctCount,
      @JsonKey(name: 'incorrect_count') int incorrectCount,
      @JsonKey(name: 'last_reviewed_at') String? lastReviewedAt,
      @JsonKey(name: 'added_at') String? addedAt,
      @JsonKey(name: 'mastered_at') String? masteredAt,
      String? tone,
      @JsonKey(name: 'cefr_level') String? cefrLevel});
}

/// @nodoc
class __$$ProgressWordImplCopyWithImpl<$Res>
    extends _$ProgressWordCopyWithImpl<$Res, _$ProgressWordImpl>
    implements _$$ProgressWordImplCopyWith<$Res> {
  __$$ProgressWordImplCopyWithImpl(
      _$ProgressWordImpl _value, $Res Function(_$ProgressWordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = freezed,
    Object? pronunciation = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? difficultyLevel = null,
    Object? importanceScore = null,
    Object? status = null,
    Object? fibonacciLevel = null,
    Object? nextReviewDate = freezed,
    Object? correctCount = null,
    Object? incorrectCount = null,
    Object? lastReviewedAt = freezed,
    Object? addedAt = freezed,
    Object? masteredAt = freezed,
    Object? tone = freezed,
    Object? cefrLevel = freezed,
  }) {
    return _then(_$ProgressWordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      word: freezed == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String?,
      pronunciation: freezed == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as double,
      importanceScore: null == importanceScore
          ? _value.importanceScore
          : importanceScore // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fibonacciLevel: null == fibonacciLevel
          ? _value.fibonacciLevel
          : fibonacciLevel // ignore: cast_nullable_to_non_nullable
              as int,
      nextReviewDate: freezed == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as String?,
      correctCount: null == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastReviewedAt: freezed == lastReviewedAt
          ? _value.lastReviewedAt
          : lastReviewedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      masteredAt: freezed == masteredAt
          ? _value.masteredAt
          : masteredAt // ignore: cast_nullable_to_non_nullable
              as String?,
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
@JsonSerializable()
class _$ProgressWordImpl implements _ProgressWord {
  const _$ProgressWordImpl(
      {required this.id,
      this.word,
      this.pronunciation,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'category_name') this.categoryName,
      @JsonKey(name: 'difficulty_level') this.difficultyLevel = 5.0,
      @JsonKey(name: 'importance_score') this.importanceScore = 50,
      required this.status,
      @JsonKey(name: 'fibonacci_level') required this.fibonacciLevel,
      @JsonKey(name: 'next_review_date') this.nextReviewDate,
      @JsonKey(name: 'correct_count') this.correctCount = 0,
      @JsonKey(name: 'incorrect_count') this.incorrectCount = 0,
      @JsonKey(name: 'last_reviewed_at') this.lastReviewedAt,
      @JsonKey(name: 'added_at') this.addedAt,
      @JsonKey(name: 'mastered_at') this.masteredAt,
      this.tone,
      @JsonKey(name: 'cefr_level') this.cefrLevel});

  factory _$ProgressWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressWordImplFromJson(json);

  @override
  final int id;
  @override
  final String? word;
  @override
  final String? pronunciation;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'difficulty_level')
  final double difficultyLevel;
  @override
  @JsonKey(name: 'importance_score')
  final int importanceScore;
  @override
  final String status;
  @override
  @JsonKey(name: 'fibonacci_level')
  final int fibonacciLevel;
  @override
  @JsonKey(name: 'next_review_date')
  final String? nextReviewDate;
  @override
  @JsonKey(name: 'correct_count')
  final int correctCount;
  @override
  @JsonKey(name: 'incorrect_count')
  final int incorrectCount;
  @override
  @JsonKey(name: 'last_reviewed_at')
  final String? lastReviewedAt;
  @override
  @JsonKey(name: 'added_at')
  final String? addedAt;
  @override
  @JsonKey(name: 'mastered_at')
  final String? masteredAt;
  @override
  final String? tone;
  @override
  @JsonKey(name: 'cefr_level')
  final String? cefrLevel;

  @override
  String toString() {
    return 'ProgressWord(id: $id, word: $word, pronunciation: $pronunciation, categoryId: $categoryId, categoryName: $categoryName, difficultyLevel: $difficultyLevel, importanceScore: $importanceScore, status: $status, fibonacciLevel: $fibonacciLevel, nextReviewDate: $nextReviewDate, correctCount: $correctCount, incorrectCount: $incorrectCount, lastReviewedAt: $lastReviewedAt, addedAt: $addedAt, masteredAt: $masteredAt, tone: $tone, cefrLevel: $cefrLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressWordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.importanceScore, importanceScore) ||
                other.importanceScore == importanceScore) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fibonacciLevel, fibonacciLevel) ||
                other.fibonacciLevel == fibonacciLevel) &&
            (identical(other.nextReviewDate, nextReviewDate) ||
                other.nextReviewDate == nextReviewDate) &&
            (identical(other.correctCount, correctCount) ||
                other.correctCount == correctCount) &&
            (identical(other.incorrectCount, incorrectCount) ||
                other.incorrectCount == incorrectCount) &&
            (identical(other.lastReviewedAt, lastReviewedAt) ||
                other.lastReviewedAt == lastReviewedAt) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.masteredAt, masteredAt) ||
                other.masteredAt == masteredAt) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.cefrLevel, cefrLevel) ||
                other.cefrLevel == cefrLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      word,
      pronunciation,
      categoryId,
      categoryName,
      difficultyLevel,
      importanceScore,
      status,
      fibonacciLevel,
      nextReviewDate,
      correctCount,
      incorrectCount,
      lastReviewedAt,
      addedAt,
      masteredAt,
      tone,
      cefrLevel);

  /// Create a copy of ProgressWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressWordImplCopyWith<_$ProgressWordImpl> get copyWith =>
      __$$ProgressWordImplCopyWithImpl<_$ProgressWordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressWordImplToJson(
      this,
    );
  }
}

abstract class _ProgressWord implements ProgressWord {
  const factory _ProgressWord(
          {required final int id,
          final String? word,
          final String? pronunciation,
          @JsonKey(name: 'category_id') final int? categoryId,
          @JsonKey(name: 'category_name') final String? categoryName,
          @JsonKey(name: 'difficulty_level') final double difficultyLevel,
          @JsonKey(name: 'importance_score') final int importanceScore,
          required final String status,
          @JsonKey(name: 'fibonacci_level') required final int fibonacciLevel,
          @JsonKey(name: 'next_review_date') final String? nextReviewDate,
          @JsonKey(name: 'correct_count') final int correctCount,
          @JsonKey(name: 'incorrect_count') final int incorrectCount,
          @JsonKey(name: 'last_reviewed_at') final String? lastReviewedAt,
          @JsonKey(name: 'added_at') final String? addedAt,
          @JsonKey(name: 'mastered_at') final String? masteredAt,
          final String? tone,
          @JsonKey(name: 'cefr_level') final String? cefrLevel}) =
      _$ProgressWordImpl;

  factory _ProgressWord.fromJson(Map<String, dynamic> json) =
      _$ProgressWordImpl.fromJson;

  @override
  int get id;
  @override
  String? get word;
  @override
  String? get pronunciation;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'difficulty_level')
  double get difficultyLevel;
  @override
  @JsonKey(name: 'importance_score')
  int get importanceScore;
  @override
  String get status;
  @override
  @JsonKey(name: 'fibonacci_level')
  int get fibonacciLevel;
  @override
  @JsonKey(name: 'next_review_date')
  String? get nextReviewDate;
  @override
  @JsonKey(name: 'correct_count')
  int get correctCount;
  @override
  @JsonKey(name: 'incorrect_count')
  int get incorrectCount;
  @override
  @JsonKey(name: 'last_reviewed_at')
  String? get lastReviewedAt;
  @override
  @JsonKey(name: 'added_at')
  String? get addedAt;
  @override
  @JsonKey(name: 'mastered_at')
  String? get masteredAt;
  @override
  String? get tone;
  @override
  @JsonKey(name: 'cefr_level')
  String? get cefrLevel;

  /// Create a copy of ProgressWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressWordImplCopyWith<_$ProgressWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressWordsResponse _$ProgressWordsResponseFromJson(
    Map<String, dynamic> json) {
  return _ProgressWordsResponse.fromJson(json);
}

/// @nodoc
mixin _$ProgressWordsResponse {
  List<ProgressWord> get words => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this ProgressWordsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressWordsResponseCopyWith<ProgressWordsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressWordsResponseCopyWith<$Res> {
  factory $ProgressWordsResponseCopyWith(ProgressWordsResponse value,
          $Res Function(ProgressWordsResponse) then) =
      _$ProgressWordsResponseCopyWithImpl<$Res, ProgressWordsResponse>;
  @useResult
  $Res call({List<ProgressWord> words, int total, String status});
}

/// @nodoc
class _$ProgressWordsResponseCopyWithImpl<$Res,
        $Val extends ProgressWordsResponse>
    implements $ProgressWordsResponseCopyWith<$Res> {
  _$ProgressWordsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? total = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<ProgressWord>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressWordsResponseImplCopyWith<$Res>
    implements $ProgressWordsResponseCopyWith<$Res> {
  factory _$$ProgressWordsResponseImplCopyWith(
          _$ProgressWordsResponseImpl value,
          $Res Function(_$ProgressWordsResponseImpl) then) =
      __$$ProgressWordsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProgressWord> words, int total, String status});
}

/// @nodoc
class __$$ProgressWordsResponseImplCopyWithImpl<$Res>
    extends _$ProgressWordsResponseCopyWithImpl<$Res,
        _$ProgressWordsResponseImpl>
    implements _$$ProgressWordsResponseImplCopyWith<$Res> {
  __$$ProgressWordsResponseImplCopyWithImpl(_$ProgressWordsResponseImpl _value,
      $Res Function(_$ProgressWordsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? total = null,
    Object? status = null,
  }) {
    return _then(_$ProgressWordsResponseImpl(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<ProgressWord>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressWordsResponseImpl implements _ProgressWordsResponse {
  const _$ProgressWordsResponseImpl(
      {required final List<ProgressWord> words,
      required this.total,
      required this.status})
      : _words = words;

  factory _$ProgressWordsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressWordsResponseImplFromJson(json);

  final List<ProgressWord> _words;
  @override
  List<ProgressWord> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  final int total;
  @override
  final String status;

  @override
  String toString() {
    return 'ProgressWordsResponse(words: $words, total: $total, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressWordsResponseImpl &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_words), total, status);

  /// Create a copy of ProgressWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressWordsResponseImplCopyWith<_$ProgressWordsResponseImpl>
      get copyWith => __$$ProgressWordsResponseImplCopyWithImpl<
          _$ProgressWordsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressWordsResponseImplToJson(
      this,
    );
  }
}

abstract class _ProgressWordsResponse implements ProgressWordsResponse {
  const factory _ProgressWordsResponse(
      {required final List<ProgressWord> words,
      required final int total,
      required final String status}) = _$ProgressWordsResponseImpl;

  factory _ProgressWordsResponse.fromJson(Map<String, dynamic> json) =
      _$ProgressWordsResponseImpl.fromJson;

  @override
  List<ProgressWord> get words;
  @override
  int get total;
  @override
  String get status;

  /// Create a copy of ProgressWordsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressWordsResponseImplCopyWith<_$ProgressWordsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MCQQuestion _$MCQQuestionFromJson(Map<String, dynamic> json) {
  return _MCQQuestion.fromJson(json);
}

/// @nodoc
mixin _$MCQQuestion {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get definition => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answer')
  String get correctAnswer => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;

  /// Serializes this MCQQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCQQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCQQuestionCopyWith<MCQQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCQQuestionCopyWith<$Res> {
  factory $MCQQuestionCopyWith(
          MCQQuestion value, $Res Function(MCQQuestion) then) =
      _$MCQQuestionCopyWithImpl<$Res, MCQQuestion>;
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      String word,
      String definition,
      List<String> options,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      int level});
}

/// @nodoc
class _$MCQQuestionCopyWithImpl<$Res, $Val extends MCQQuestion>
    implements $MCQQuestionCopyWith<$Res> {
  _$MCQQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCQQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = null,
    Object? definition = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      definition: null == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MCQQuestionImplCopyWith<$Res>
    implements $MCQQuestionCopyWith<$Res> {
  factory _$$MCQQuestionImplCopyWith(
          _$MCQQuestionImpl value, $Res Function(_$MCQQuestionImpl) then) =
      __$$MCQQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'word_id') int wordId,
      String word,
      String definition,
      List<String> options,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      int level});
}

/// @nodoc
class __$$MCQQuestionImplCopyWithImpl<$Res>
    extends _$MCQQuestionCopyWithImpl<$Res, _$MCQQuestionImpl>
    implements _$$MCQQuestionImplCopyWith<$Res> {
  __$$MCQQuestionImplCopyWithImpl(
      _$MCQQuestionImpl _value, $Res Function(_$MCQQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MCQQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? word = null,
    Object? definition = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? level = null,
  }) {
    return _then(_$MCQQuestionImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      definition: null == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MCQQuestionImpl implements _MCQQuestion {
  const _$MCQQuestionImpl(
      {@JsonKey(name: 'word_id') required this.wordId,
      required this.word,
      required this.definition,
      required final List<String> options,
      @JsonKey(name: 'correct_answer') required this.correctAnswer,
      required this.level})
      : _options = options;

  factory _$MCQQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCQQuestionImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String word;
  @override
  final String definition;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  @override
  final int level;

  @override
  String toString() {
    return 'MCQQuestion(wordId: $wordId, word: $word, definition: $definition, options: $options, correctAnswer: $correctAnswer, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCQQuestionImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wordId, word, definition,
      const DeepCollectionEquality().hash(_options), correctAnswer, level);

  /// Create a copy of MCQQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCQQuestionImplCopyWith<_$MCQQuestionImpl> get copyWith =>
      __$$MCQQuestionImplCopyWithImpl<_$MCQQuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MCQQuestionImplToJson(
      this,
    );
  }
}

abstract class _MCQQuestion implements MCQQuestion {
  const factory _MCQQuestion(
      {@JsonKey(name: 'word_id') required final int wordId,
      required final String word,
      required final String definition,
      required final List<String> options,
      @JsonKey(name: 'correct_answer') required final String correctAnswer,
      required final int level}) = _$MCQQuestionImpl;

  factory _MCQQuestion.fromJson(Map<String, dynamic> json) =
      _$MCQQuestionImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String get word;
  @override
  String get definition;
  @override
  List<String> get options;
  @override
  @JsonKey(name: 'correct_answer')
  String get correctAnswer;
  @override
  int get level;

  /// Create a copy of MCQQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCQQuestionImplCopyWith<_$MCQQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyStackQuestion {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_date')
  String get scheduledDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_reviewed')
  bool get isReviewed => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  MCQQuestion get question => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_detail')
  WordDetail get wordDetail => throw _privateConstructorUsedError;

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyStackQuestionCopyWith<DailyStackQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStackQuestionCopyWith<$Res> {
  factory $DailyStackQuestionCopyWith(
          DailyStackQuestion value, $Res Function(DailyStackQuestion) then) =
      _$DailyStackQuestionCopyWithImpl<$Res, DailyStackQuestion>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'word_id') int wordId,
      @JsonKey(name: 'scheduled_date') String scheduledDate,
      @JsonKey(name: 'is_reviewed') bool isReviewed,
      int level,
      MCQQuestion question,
      @JsonKey(name: 'word_detail') WordDetail wordDetail});

  $MCQQuestionCopyWith<$Res> get question;
  $WordDetailCopyWith<$Res> get wordDetail;
}

/// @nodoc
class _$DailyStackQuestionCopyWithImpl<$Res, $Val extends DailyStackQuestion>
    implements $DailyStackQuestionCopyWith<$Res> {
  _$DailyStackQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wordId = null,
    Object? scheduledDate = null,
    Object? isReviewed = null,
    Object? level = null,
    Object? question = null,
    Object? wordDetail = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledDate: null == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as String,
      isReviewed: null == isReviewed
          ? _value.isReviewed
          : isReviewed // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as MCQQuestion,
      wordDetail: null == wordDetail
          ? _value.wordDetail
          : wordDetail // ignore: cast_nullable_to_non_nullable
              as WordDetail,
    ) as $Val);
  }

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MCQQuestionCopyWith<$Res> get question {
    return $MCQQuestionCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value) as $Val);
    });
  }

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WordDetailCopyWith<$Res> get wordDetail {
    return $WordDetailCopyWith<$Res>(_value.wordDetail, (value) {
      return _then(_value.copyWith(wordDetail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyStackQuestionImplCopyWith<$Res>
    implements $DailyStackQuestionCopyWith<$Res> {
  factory _$$DailyStackQuestionImplCopyWith(_$DailyStackQuestionImpl value,
          $Res Function(_$DailyStackQuestionImpl) then) =
      __$$DailyStackQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'word_id') int wordId,
      @JsonKey(name: 'scheduled_date') String scheduledDate,
      @JsonKey(name: 'is_reviewed') bool isReviewed,
      int level,
      MCQQuestion question,
      @JsonKey(name: 'word_detail') WordDetail wordDetail});

  @override
  $MCQQuestionCopyWith<$Res> get question;
  @override
  $WordDetailCopyWith<$Res> get wordDetail;
}

/// @nodoc
class __$$DailyStackQuestionImplCopyWithImpl<$Res>
    extends _$DailyStackQuestionCopyWithImpl<$Res, _$DailyStackQuestionImpl>
    implements _$$DailyStackQuestionImplCopyWith<$Res> {
  __$$DailyStackQuestionImplCopyWithImpl(_$DailyStackQuestionImpl _value,
      $Res Function(_$DailyStackQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wordId = null,
    Object? scheduledDate = null,
    Object? isReviewed = null,
    Object? level = null,
    Object? question = null,
    Object? wordDetail = null,
  }) {
    return _then(_$DailyStackQuestionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledDate: null == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as String,
      isReviewed: null == isReviewed
          ? _value.isReviewed
          : isReviewed // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as MCQQuestion,
      wordDetail: null == wordDetail
          ? _value.wordDetail
          : wordDetail // ignore: cast_nullable_to_non_nullable
              as WordDetail,
    ));
  }
}

/// @nodoc

class _$DailyStackQuestionImpl implements _DailyStackQuestion {
  const _$DailyStackQuestionImpl(
      {required this.id,
      @JsonKey(name: 'word_id') required this.wordId,
      @JsonKey(name: 'scheduled_date') required this.scheduledDate,
      @JsonKey(name: 'is_reviewed') required this.isReviewed,
      required this.level,
      required this.question,
      @JsonKey(name: 'word_detail') required this.wordDetail});

  @override
  final int id;
  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  @JsonKey(name: 'scheduled_date')
  final String scheduledDate;
  @override
  @JsonKey(name: 'is_reviewed')
  final bool isReviewed;
  @override
  final int level;
  @override
  final MCQQuestion question;
  @override
  @JsonKey(name: 'word_detail')
  final WordDetail wordDetail;

  @override
  String toString() {
    return 'DailyStackQuestion(id: $id, wordId: $wordId, scheduledDate: $scheduledDate, isReviewed: $isReviewed, level: $level, question: $question, wordDetail: $wordDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStackQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.isReviewed, isReviewed) ||
                other.isReviewed == isReviewed) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.wordDetail, wordDetail) ||
                other.wordDetail == wordDetail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, wordId, scheduledDate,
      isReviewed, level, question, wordDetail);

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStackQuestionImplCopyWith<_$DailyStackQuestionImpl> get copyWith =>
      __$$DailyStackQuestionImplCopyWithImpl<_$DailyStackQuestionImpl>(
          this, _$identity);
}

abstract class _DailyStackQuestion implements DailyStackQuestion {
  const factory _DailyStackQuestion(
          {required final int id,
          @JsonKey(name: 'word_id') required final int wordId,
          @JsonKey(name: 'scheduled_date') required final String scheduledDate,
          @JsonKey(name: 'is_reviewed') required final bool isReviewed,
          required final int level,
          required final MCQQuestion question,
          @JsonKey(name: 'word_detail') required final WordDetail wordDetail}) =
      _$DailyStackQuestionImpl;

  @override
  int get id;
  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  @JsonKey(name: 'scheduled_date')
  String get scheduledDate;
  @override
  @JsonKey(name: 'is_reviewed')
  bool get isReviewed;
  @override
  int get level;
  @override
  MCQQuestion get question;
  @override
  @JsonKey(name: 'word_detail')
  WordDetail get wordDetail;

  /// Create a copy of DailyStackQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyStackQuestionImplCopyWith<_$DailyStackQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
