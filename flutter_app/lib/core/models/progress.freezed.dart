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
  int get wordId => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get scheduledDate => throw _privateConstructorUsedError;
  bool get isReviewed => throw _privateConstructorUsedError;

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
      {int id, int wordId, String word, String scheduledDate, bool isReviewed});
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
      {int id, int wordId, String word, String scheduledDate, bool isReviewed});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStackItemImpl implements _DailyStackItem {
  const _$DailyStackItemImpl(
      {required this.id,
      required this.wordId,
      required this.word,
      required this.scheduledDate,
      required this.isReviewed});

  factory _$DailyStackItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStackItemImplFromJson(json);

  @override
  final int id;
  @override
  final int wordId;
  @override
  final String word;
  @override
  final String scheduledDate;
  @override
  final bool isReviewed;

  @override
  String toString() {
    return 'DailyStackItem(id: $id, wordId: $wordId, word: $word, scheduledDate: $scheduledDate, isReviewed: $isReviewed)';
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
                other.isReviewed == isReviewed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, wordId, word, scheduledDate, isReviewed);

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
      required final int wordId,
      required final String word,
      required final String scheduledDate,
      required final bool isReviewed}) = _$DailyStackItemImpl;

  factory _DailyStackItem.fromJson(Map<String, dynamic> json) =
      _$DailyStackItemImpl.fromJson;

  @override
  int get id;
  @override
  int get wordId;
  @override
  String get word;
  @override
  String get scheduledDate;
  @override
  bool get isReviewed;

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
  $Res call({List<int> wordIds});
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
  $Res call({List<int> wordIds});
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
  const _$AddWordsRequestImpl({required final List<int> wordIds})
      : _wordIds = wordIds;

  factory _$AddWordsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddWordsRequestImplFromJson(json);

  final List<int> _wordIds;
  @override
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
  const factory _AddWordsRequest({required final List<int> wordIds}) =
      _$AddWordsRequestImpl;

  factory _AddWordsRequest.fromJson(Map<String, dynamic> json) =
      _$AddWordsRequestImpl.fromJson;

  @override
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
  $Res call({String message, int addedCount});
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
  $Res call({String message, int addedCount});
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
      {required this.message, required this.addedCount});

  factory _$AddWordsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddWordsResponseImplFromJson(json);

  @override
  final String message;
  @override
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
      required final int addedCount}) = _$AddWordsResponseImpl;

  factory _AddWordsResponse.fromJson(Map<String, dynamic> json) =
      _$AddWordsResponseImpl.fromJson;

  @override
  String get message;
  @override
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
  int get wordId => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  String? get userAnswer => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  int? get timeTakenSeconds => throw _privateConstructorUsedError;
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
      {int wordId,
      bool isCorrect,
      String questionType,
      String? userAnswer,
      String correctAnswer,
      int? timeTakenSeconds,
      List<String>? optionsPresented});
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
      {int wordId,
      bool isCorrect,
      String questionType,
      String? userAnswer,
      String correctAnswer,
      int? timeTakenSeconds,
      List<String>? optionsPresented});
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
      {required this.wordId,
      required this.isCorrect,
      required this.questionType,
      this.userAnswer,
      required this.correctAnswer,
      this.timeTakenSeconds,
      final List<String>? optionsPresented})
      : _optionsPresented = optionsPresented;

  factory _$ReviewSubmitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewSubmitImplFromJson(json);

  @override
  final int wordId;
  @override
  final bool isCorrect;
  @override
  final String questionType;
  @override
  final String? userAnswer;
  @override
  final String correctAnswer;
  @override
  final int? timeTakenSeconds;
  final List<String>? _optionsPresented;
  @override
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
      {required final int wordId,
      required final bool isCorrect,
      required final String questionType,
      final String? userAnswer,
      required final String correctAnswer,
      final int? timeTakenSeconds,
      final List<String>? optionsPresented}) = _$ReviewSubmitImpl;

  factory _ReviewSubmit.fromJson(Map<String, dynamic> json) =
      _$ReviewSubmitImpl.fromJson;

  @override
  int get wordId;
  @override
  bool get isCorrect;
  @override
  String get questionType;
  @override
  String? get userAnswer;
  @override
  String get correctAnswer;
  @override
  int? get timeTakenSeconds;
  @override
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
  int get newLevel => throw _privateConstructorUsedError;
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
      int newLevel,
      String? nextReviewDate,
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
      int newLevel,
      String? nextReviewDate,
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
      required this.newLevel,
      this.nextReviewDate,
      required this.status,
      required this.message});

  factory _$ReviewResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final int newLevel;
  @override
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
      required final int newLevel,
      final String? nextReviewDate,
      required final String status,
      required final String message}) = _$ReviewResponseImpl;

  factory _ReviewResponse.fromJson(Map<String, dynamic> json) =
      _$ReviewResponseImpl.fromJson;

  @override
  bool get success;
  @override
  int get newLevel;
  @override
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
  int get wordId => throw _privateConstructorUsedError;
  String? get word => throw _privateConstructorUsedError;
  int get fibonacciLevel => throw _privateConstructorUsedError;
  String? get nextReviewDate => throw _privateConstructorUsedError;
  int get correctCount => throw _privateConstructorUsedError;
  int get incorrectCount => throw _privateConstructorUsedError;
  String? get lastReviewedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get addedAt => throw _privateConstructorUsedError;
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
      {int wordId,
      String? word,
      int fibonacciLevel,
      String? nextReviewDate,
      int correctCount,
      int incorrectCount,
      String? lastReviewedAt,
      String status,
      String? addedAt,
      String? masteredAt});
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
      {int wordId,
      String? word,
      int fibonacciLevel,
      String? nextReviewDate,
      int correctCount,
      int incorrectCount,
      String? lastReviewedAt,
      String status,
      String? addedAt,
      String? masteredAt});
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
      {required this.wordId,
      this.word,
      required this.fibonacciLevel,
      this.nextReviewDate,
      required this.correctCount,
      required this.incorrectCount,
      this.lastReviewedAt,
      required this.status,
      this.addedAt,
      this.masteredAt});

  factory _$WordProgressDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordProgressDetailImplFromJson(json);

  @override
  final int wordId;
  @override
  final String? word;
  @override
  final int fibonacciLevel;
  @override
  final String? nextReviewDate;
  @override
  final int correctCount;
  @override
  final int incorrectCount;
  @override
  final String? lastReviewedAt;
  @override
  final String status;
  @override
  final String? addedAt;
  @override
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
      {required final int wordId,
      final String? word,
      required final int fibonacciLevel,
      final String? nextReviewDate,
      required final int correctCount,
      required final int incorrectCount,
      final String? lastReviewedAt,
      required final String status,
      final String? addedAt,
      final String? masteredAt}) = _$WordProgressDetailImpl;

  factory _WordProgressDetail.fromJson(Map<String, dynamic> json) =
      _$WordProgressDetailImpl.fromJson;

  @override
  int get wordId;
  @override
  String? get word;
  @override
  int get fibonacciLevel;
  @override
  String? get nextReviewDate;
  @override
  int get correctCount;
  @override
  int get incorrectCount;
  @override
  String? get lastReviewedAt;
  @override
  String get status;
  @override
  String? get addedAt;
  @override
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
  int get wordId => throw _privateConstructorUsedError;
  String? get word => throw _privateConstructorUsedError;
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
  $Res call({int wordId, String? word, String? reviewDate, int level});
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
  $Res call({int wordId, String? word, String? reviewDate, int level});
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
      {required this.wordId, this.word, this.reviewDate, required this.level});

  factory _$UpcomingReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpcomingReviewImplFromJson(json);

  @override
  final int wordId;
  @override
  final String? word;
  @override
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
      {required final int wordId,
      final String? word,
      final String? reviewDate,
      required final int level}) = _$UpcomingReviewImpl;

  factory _UpcomingReview.fromJson(Map<String, dynamic> json) =
      _$UpcomingReviewImpl.fromJson;

  @override
  int get wordId;
  @override
  String? get word;
  @override
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
