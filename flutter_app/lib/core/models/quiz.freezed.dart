// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuizGenerateRequest _$QuizGenerateRequestFromJson(Map<String, dynamic> json) {
  return _QuizGenerateRequest.fromJson(json);
}

/// @nodoc
mixin _$QuizGenerateRequest {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;

  /// Serializes this QuizGenerateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizGenerateRequestCopyWith<QuizGenerateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizGenerateRequestCopyWith<$Res> {
  factory $QuizGenerateRequestCopyWith(
          QuizGenerateRequest value, $Res Function(QuizGenerateRequest) then) =
      _$QuizGenerateRequestCopyWithImpl<$Res, QuizGenerateRequest>;
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId});
}

/// @nodoc
class _$QuizGenerateRequestCopyWithImpl<$Res, $Val extends QuizGenerateRequest>
    implements $QuizGenerateRequestCopyWith<$Res> {
  _$QuizGenerateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizGenerateRequestImplCopyWith<$Res>
    implements $QuizGenerateRequestCopyWith<$Res> {
  factory _$$QuizGenerateRequestImplCopyWith(_$QuizGenerateRequestImpl value,
          $Res Function(_$QuizGenerateRequestImpl) then) =
      __$$QuizGenerateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId});
}

/// @nodoc
class __$$QuizGenerateRequestImplCopyWithImpl<$Res>
    extends _$QuizGenerateRequestCopyWithImpl<$Res, _$QuizGenerateRequestImpl>
    implements _$$QuizGenerateRequestImplCopyWith<$Res> {
  __$$QuizGenerateRequestImplCopyWithImpl(_$QuizGenerateRequestImpl _value,
      $Res Function(_$QuizGenerateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
  }) {
    return _then(_$QuizGenerateRequestImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizGenerateRequestImpl implements _QuizGenerateRequest {
  const _$QuizGenerateRequestImpl(
      {@JsonKey(name: 'word_id') required this.wordId});

  factory _$QuizGenerateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizGenerateRequestImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;

  @override
  String toString() {
    return 'QuizGenerateRequest(wordId: $wordId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizGenerateRequestImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wordId);

  /// Create a copy of QuizGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizGenerateRequestImplCopyWith<_$QuizGenerateRequestImpl> get copyWith =>
      __$$QuizGenerateRequestImplCopyWithImpl<_$QuizGenerateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizGenerateRequestImplToJson(
      this,
    );
  }
}

abstract class _QuizGenerateRequest implements QuizGenerateRequest {
  const factory _QuizGenerateRequest(
          {@JsonKey(name: 'word_id') required final int wordId}) =
      _$QuizGenerateRequestImpl;

  factory _QuizGenerateRequest.fromJson(Map<String, dynamic> json) =
      _$QuizGenerateRequestImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;

  /// Create a copy of QuizGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizGenerateRequestImplCopyWith<_$QuizGenerateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizOption _$QuizOptionFromJson(Map<String, dynamic> json) {
  return _QuizOption.fromJson(json);
}

/// @nodoc
mixin _$QuizOption {
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_correct')
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this QuizOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizOptionCopyWith<QuizOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizOptionCopyWith<$Res> {
  factory $QuizOptionCopyWith(
          QuizOption value, $Res Function(QuizOption) then) =
      _$QuizOptionCopyWithImpl<$Res, QuizOption>;
  @useResult
  $Res call({String text, @JsonKey(name: 'is_correct') bool isCorrect});
}

/// @nodoc
class _$QuizOptionCopyWithImpl<$Res, $Val extends QuizOption>
    implements $QuizOptionCopyWith<$Res> {
  _$QuizOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isCorrect = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizOptionImplCopyWith<$Res>
    implements $QuizOptionCopyWith<$Res> {
  factory _$$QuizOptionImplCopyWith(
          _$QuizOptionImpl value, $Res Function(_$QuizOptionImpl) then) =
      __$$QuizOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, @JsonKey(name: 'is_correct') bool isCorrect});
}

/// @nodoc
class __$$QuizOptionImplCopyWithImpl<$Res>
    extends _$QuizOptionCopyWithImpl<$Res, _$QuizOptionImpl>
    implements _$$QuizOptionImplCopyWith<$Res> {
  __$$QuizOptionImplCopyWithImpl(
      _$QuizOptionImpl _value, $Res Function(_$QuizOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isCorrect = null,
  }) {
    return _then(_$QuizOptionImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizOptionImpl implements _QuizOption {
  const _$QuizOptionImpl(
      {required this.text,
      @JsonKey(name: 'is_correct') this.isCorrect = false});

  factory _$QuizOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizOptionImplFromJson(json);

  @override
  final String text;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  @override
  String toString() {
    return 'QuizOption(text: $text, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizOptionImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, isCorrect);

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizOptionImplCopyWith<_$QuizOptionImpl> get copyWith =>
      __$$QuizOptionImplCopyWithImpl<_$QuizOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizOptionImplToJson(
      this,
    );
  }
}

abstract class _QuizOption implements QuizOption {
  const factory _QuizOption(
      {required final String text,
      @JsonKey(name: 'is_correct') final bool isCorrect}) = _$QuizOptionImpl;

  factory _QuizOption.fromJson(Map<String, dynamic> json) =
      _$QuizOptionImpl.fromJson;

  @override
  String get text;
  @override
  @JsonKey(name: 'is_correct')
  bool get isCorrect;

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizOptionImplCopyWith<_$QuizOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) {
  return _QuizResponse.fromJson(json);
}

/// @nodoc
mixin _$QuizResponse {
  String get question => throw _privateConstructorUsedError;
  List<QuizOption> get options => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answer')
  String get correctAnswer => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;

  /// Serializes this QuizResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizResponseCopyWith<QuizResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResponseCopyWith<$Res> {
  factory $QuizResponseCopyWith(
          QuizResponse value, $Res Function(QuizResponse) then) =
      _$QuizResponseCopyWithImpl<$Res, QuizResponse>;
  @useResult
  $Res call(
      {String question,
      List<QuizOption> options,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      String? explanation});
}

/// @nodoc
class _$QuizResponseCopyWithImpl<$Res, $Val extends QuizResponse>
    implements $QuizResponseCopyWith<$Res> {
  _$QuizResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? explanation = freezed,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<QuizOption>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizResponseImplCopyWith<$Res>
    implements $QuizResponseCopyWith<$Res> {
  factory _$$QuizResponseImplCopyWith(
          _$QuizResponseImpl value, $Res Function(_$QuizResponseImpl) then) =
      __$$QuizResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String question,
      List<QuizOption> options,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      String? explanation});
}

/// @nodoc
class __$$QuizResponseImplCopyWithImpl<$Res>
    extends _$QuizResponseCopyWithImpl<$Res, _$QuizResponseImpl>
    implements _$$QuizResponseImplCopyWith<$Res> {
  __$$QuizResponseImplCopyWithImpl(
      _$QuizResponseImpl _value, $Res Function(_$QuizResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? explanation = freezed,
  }) {
    return _then(_$QuizResponseImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<QuizOption>,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizResponseImpl implements _QuizResponse {
  const _$QuizResponseImpl(
      {required this.question,
      required final List<QuizOption> options,
      @JsonKey(name: 'correct_answer') required this.correctAnswer,
      this.explanation})
      : _options = options;

  factory _$QuizResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizResponseImplFromJson(json);

  @override
  final String question;
  final List<QuizOption> _options;
  @override
  List<QuizOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  @override
  final String? explanation;

  @override
  String toString() {
    return 'QuizResponse(question: $question, options: $options, correctAnswer: $correctAnswer, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizResponseImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      question,
      const DeepCollectionEquality().hash(_options),
      correctAnswer,
      explanation);

  /// Create a copy of QuizResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizResponseImplCopyWith<_$QuizResponseImpl> get copyWith =>
      __$$QuizResponseImplCopyWithImpl<_$QuizResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizResponseImplToJson(
      this,
    );
  }
}

abstract class _QuizResponse implements QuizResponse {
  const factory _QuizResponse(
      {required final String question,
      required final List<QuizOption> options,
      @JsonKey(name: 'correct_answer') required final String correctAnswer,
      final String? explanation}) = _$QuizResponseImpl;

  factory _QuizResponse.fromJson(Map<String, dynamic> json) =
      _$QuizResponseImpl.fromJson;

  @override
  String get question;
  @override
  List<QuizOption> get options;
  @override
  @JsonKey(name: 'correct_answer')
  String get correctAnswer;
  @override
  String? get explanation;

  /// Create a copy of QuizResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizResponseImplCopyWith<_$QuizResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExplainRequest _$ExplainRequestFromJson(Map<String, dynamic> json) {
  return _ExplainRequest.fromJson(json);
}

/// @nodoc
mixin _$ExplainRequest {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;

  /// Serializes this ExplainRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplainRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplainRequestCopyWith<ExplainRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplainRequestCopyWith<$Res> {
  factory $ExplainRequestCopyWith(
          ExplainRequest value, $Res Function(ExplainRequest) then) =
      _$ExplainRequestCopyWithImpl<$Res, ExplainRequest>;
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId, String question});
}

/// @nodoc
class _$ExplainRequestCopyWithImpl<$Res, $Val extends ExplainRequest>
    implements $ExplainRequestCopyWith<$Res> {
  _$ExplainRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplainRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? question = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExplainRequestImplCopyWith<$Res>
    implements $ExplainRequestCopyWith<$Res> {
  factory _$$ExplainRequestImplCopyWith(_$ExplainRequestImpl value,
          $Res Function(_$ExplainRequestImpl) then) =
      __$$ExplainRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId, String question});
}

/// @nodoc
class __$$ExplainRequestImplCopyWithImpl<$Res>
    extends _$ExplainRequestCopyWithImpl<$Res, _$ExplainRequestImpl>
    implements _$$ExplainRequestImplCopyWith<$Res> {
  __$$ExplainRequestImplCopyWithImpl(
      _$ExplainRequestImpl _value, $Res Function(_$ExplainRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplainRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? question = null,
  }) {
    return _then(_$ExplainRequestImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplainRequestImpl implements _ExplainRequest {
  const _$ExplainRequestImpl(
      {@JsonKey(name: 'word_id') required this.wordId, required this.question});

  factory _$ExplainRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplainRequestImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String question;

  @override
  String toString() {
    return 'ExplainRequest(wordId: $wordId, question: $question)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplainRequestImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wordId, question);

  /// Create a copy of ExplainRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplainRequestImplCopyWith<_$ExplainRequestImpl> get copyWith =>
      __$$ExplainRequestImplCopyWithImpl<_$ExplainRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplainRequestImplToJson(
      this,
    );
  }
}

abstract class _ExplainRequest implements ExplainRequest {
  const factory _ExplainRequest(
      {@JsonKey(name: 'word_id') required final int wordId,
      required final String question}) = _$ExplainRequestImpl;

  factory _ExplainRequest.fromJson(Map<String, dynamic> json) =
      _$ExplainRequestImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String get question;

  /// Create a copy of ExplainRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplainRequestImplCopyWith<_$ExplainRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExplainResponse _$ExplainResponseFromJson(Map<String, dynamic> json) {
  return _ExplainResponse.fromJson(json);
}

/// @nodoc
mixin _$ExplainResponse {
  String get answer => throw _privateConstructorUsedError;

  /// Serializes this ExplainResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplainResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplainResponseCopyWith<ExplainResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplainResponseCopyWith<$Res> {
  factory $ExplainResponseCopyWith(
          ExplainResponse value, $Res Function(ExplainResponse) then) =
      _$ExplainResponseCopyWithImpl<$Res, ExplainResponse>;
  @useResult
  $Res call({String answer});
}

/// @nodoc
class _$ExplainResponseCopyWithImpl<$Res, $Val extends ExplainResponse>
    implements $ExplainResponseCopyWith<$Res> {
  _$ExplainResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplainResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answer = null,
  }) {
    return _then(_value.copyWith(
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExplainResponseImplCopyWith<$Res>
    implements $ExplainResponseCopyWith<$Res> {
  factory _$$ExplainResponseImplCopyWith(_$ExplainResponseImpl value,
          $Res Function(_$ExplainResponseImpl) then) =
      __$$ExplainResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String answer});
}

/// @nodoc
class __$$ExplainResponseImplCopyWithImpl<$Res>
    extends _$ExplainResponseCopyWithImpl<$Res, _$ExplainResponseImpl>
    implements _$$ExplainResponseImplCopyWith<$Res> {
  __$$ExplainResponseImplCopyWithImpl(
      _$ExplainResponseImpl _value, $Res Function(_$ExplainResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplainResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answer = null,
  }) {
    return _then(_$ExplainResponseImpl(
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplainResponseImpl implements _ExplainResponse {
  const _$ExplainResponseImpl({required this.answer});

  factory _$ExplainResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplainResponseImplFromJson(json);

  @override
  final String answer;

  @override
  String toString() {
    return 'ExplainResponse(answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplainResponseImpl &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, answer);

  /// Create a copy of ExplainResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplainResponseImplCopyWith<_$ExplainResponseImpl> get copyWith =>
      __$$ExplainResponseImplCopyWithImpl<_$ExplainResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplainResponseImplToJson(
      this,
    );
  }
}

abstract class _ExplainResponse implements ExplainResponse {
  const factory _ExplainResponse({required final String answer}) =
      _$ExplainResponseImpl;

  factory _ExplainResponse.fromJson(Map<String, dynamic> json) =
      _$ExplainResponseImpl.fromJson;

  @override
  String get answer;

  /// Create a copy of ExplainResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplainResponseImplCopyWith<_$ExplainResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryGenerateRequest _$StoryGenerateRequestFromJson(Map<String, dynamic> json) {
  return _StoryGenerateRequest.fromJson(json);
}

/// @nodoc
mixin _$StoryGenerateRequest {
  @JsonKey(name: 'word_ids')
  List<int> get wordIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'batch_size')
  int get batchSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'story_type')
  String get storyType => throw _privateConstructorUsedError;

  /// Serializes this StoryGenerateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryGenerateRequestCopyWith<StoryGenerateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryGenerateRequestCopyWith<$Res> {
  factory $StoryGenerateRequestCopyWith(StoryGenerateRequest value,
          $Res Function(StoryGenerateRequest) then) =
      _$StoryGenerateRequestCopyWithImpl<$Res, StoryGenerateRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'word_ids') List<int> wordIds,
      @JsonKey(name: 'batch_size') int batchSize,
      @JsonKey(name: 'story_type') String storyType});
}

/// @nodoc
class _$StoryGenerateRequestCopyWithImpl<$Res,
        $Val extends StoryGenerateRequest>
    implements $StoryGenerateRequestCopyWith<$Res> {
  _$StoryGenerateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordIds = null,
    Object? batchSize = null,
    Object? storyType = null,
  }) {
    return _then(_value.copyWith(
      wordIds: null == wordIds
          ? _value.wordIds
          : wordIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      batchSize: null == batchSize
          ? _value.batchSize
          : batchSize // ignore: cast_nullable_to_non_nullable
              as int,
      storyType: null == storyType
          ? _value.storyType
          : storyType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryGenerateRequestImplCopyWith<$Res>
    implements $StoryGenerateRequestCopyWith<$Res> {
  factory _$$StoryGenerateRequestImplCopyWith(_$StoryGenerateRequestImpl value,
          $Res Function(_$StoryGenerateRequestImpl) then) =
      __$$StoryGenerateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'word_ids') List<int> wordIds,
      @JsonKey(name: 'batch_size') int batchSize,
      @JsonKey(name: 'story_type') String storyType});
}

/// @nodoc
class __$$StoryGenerateRequestImplCopyWithImpl<$Res>
    extends _$StoryGenerateRequestCopyWithImpl<$Res, _$StoryGenerateRequestImpl>
    implements _$$StoryGenerateRequestImplCopyWith<$Res> {
  __$$StoryGenerateRequestImplCopyWithImpl(_$StoryGenerateRequestImpl _value,
      $Res Function(_$StoryGenerateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordIds = null,
    Object? batchSize = null,
    Object? storyType = null,
  }) {
    return _then(_$StoryGenerateRequestImpl(
      wordIds: null == wordIds
          ? _value._wordIds
          : wordIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      batchSize: null == batchSize
          ? _value.batchSize
          : batchSize // ignore: cast_nullable_to_non_nullable
              as int,
      storyType: null == storyType
          ? _value.storyType
          : storyType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryGenerateRequestImpl implements _StoryGenerateRequest {
  const _$StoryGenerateRequestImpl(
      {@JsonKey(name: 'word_ids') required final List<int> wordIds,
      @JsonKey(name: 'batch_size') this.batchSize = 20,
      @JsonKey(name: 'story_type') this.storyType = 'daily'})
      : _wordIds = wordIds;

  factory _$StoryGenerateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryGenerateRequestImplFromJson(json);

  final List<int> _wordIds;
  @override
  @JsonKey(name: 'word_ids')
  List<int> get wordIds {
    if (_wordIds is EqualUnmodifiableListView) return _wordIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wordIds);
  }

  @override
  @JsonKey(name: 'batch_size')
  final int batchSize;
  @override
  @JsonKey(name: 'story_type')
  final String storyType;

  @override
  String toString() {
    return 'StoryGenerateRequest(wordIds: $wordIds, batchSize: $batchSize, storyType: $storyType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryGenerateRequestImpl &&
            const DeepCollectionEquality().equals(other._wordIds, _wordIds) &&
            (identical(other.batchSize, batchSize) ||
                other.batchSize == batchSize) &&
            (identical(other.storyType, storyType) ||
                other.storyType == storyType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_wordIds), batchSize, storyType);

  /// Create a copy of StoryGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryGenerateRequestImplCopyWith<_$StoryGenerateRequestImpl>
      get copyWith =>
          __$$StoryGenerateRequestImplCopyWithImpl<_$StoryGenerateRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryGenerateRequestImplToJson(
      this,
    );
  }
}

abstract class _StoryGenerateRequest implements StoryGenerateRequest {
  const factory _StoryGenerateRequest(
          {@JsonKey(name: 'word_ids') required final List<int> wordIds,
          @JsonKey(name: 'batch_size') final int batchSize,
          @JsonKey(name: 'story_type') final String storyType}) =
      _$StoryGenerateRequestImpl;

  factory _StoryGenerateRequest.fromJson(Map<String, dynamic> json) =
      _$StoryGenerateRequestImpl.fromJson;

  @override
  @JsonKey(name: 'word_ids')
  List<int> get wordIds;
  @override
  @JsonKey(name: 'batch_size')
  int get batchSize;
  @override
  @JsonKey(name: 'story_type')
  String get storyType;

  /// Create a copy of StoryGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryGenerateRequestImplCopyWith<_$StoryGenerateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) {
  return _StoryResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryResponse {
  @JsonKey(name: 'story_id')
  int get storyId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get narrative => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_ids')
  List<int> get wordIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'story_type')
  String get storyType => throw _privateConstructorUsedError;

  /// Serializes this StoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryResponseCopyWith<StoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryResponseCopyWith<$Res> {
  factory $StoryResponseCopyWith(
          StoryResponse value, $Res Function(StoryResponse) then) =
      _$StoryResponseCopyWithImpl<$Res, StoryResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'story_id') int storyId,
      String title,
      String narrative,
      @JsonKey(name: 'word_ids') List<int> wordIds,
      @JsonKey(name: 'story_type') String storyType});
}

/// @nodoc
class _$StoryResponseCopyWithImpl<$Res, $Val extends StoryResponse>
    implements $StoryResponseCopyWith<$Res> {
  _$StoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? title = null,
    Object? narrative = null,
    Object? wordIds = null,
    Object? storyType = null,
  }) {
    return _then(_value.copyWith(
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      narrative: null == narrative
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as String,
      wordIds: null == wordIds
          ? _value.wordIds
          : wordIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      storyType: null == storyType
          ? _value.storyType
          : storyType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryResponseImplCopyWith<$Res>
    implements $StoryResponseCopyWith<$Res> {
  factory _$$StoryResponseImplCopyWith(
          _$StoryResponseImpl value, $Res Function(_$StoryResponseImpl) then) =
      __$$StoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'story_id') int storyId,
      String title,
      String narrative,
      @JsonKey(name: 'word_ids') List<int> wordIds,
      @JsonKey(name: 'story_type') String storyType});
}

/// @nodoc
class __$$StoryResponseImplCopyWithImpl<$Res>
    extends _$StoryResponseCopyWithImpl<$Res, _$StoryResponseImpl>
    implements _$$StoryResponseImplCopyWith<$Res> {
  __$$StoryResponseImplCopyWithImpl(
      _$StoryResponseImpl _value, $Res Function(_$StoryResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = null,
    Object? title = null,
    Object? narrative = null,
    Object? wordIds = null,
    Object? storyType = null,
  }) {
    return _then(_$StoryResponseImpl(
      storyId: null == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      narrative: null == narrative
          ? _value.narrative
          : narrative // ignore: cast_nullable_to_non_nullable
              as String,
      wordIds: null == wordIds
          ? _value._wordIds
          : wordIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      storyType: null == storyType
          ? _value.storyType
          : storyType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryResponseImpl implements _StoryResponse {
  const _$StoryResponseImpl(
      {@JsonKey(name: 'story_id') required this.storyId,
      required this.title,
      required this.narrative,
      @JsonKey(name: 'word_ids') required final List<int> wordIds,
      @JsonKey(name: 'story_type') required this.storyType})
      : _wordIds = wordIds;

  factory _$StoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryResponseImplFromJson(json);

  @override
  @JsonKey(name: 'story_id')
  final int storyId;
  @override
  final String title;
  @override
  final String narrative;
  final List<int> _wordIds;
  @override
  @JsonKey(name: 'word_ids')
  List<int> get wordIds {
    if (_wordIds is EqualUnmodifiableListView) return _wordIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wordIds);
  }

  @override
  @JsonKey(name: 'story_type')
  final String storyType;

  @override
  String toString() {
    return 'StoryResponse(storyId: $storyId, title: $title, narrative: $narrative, wordIds: $wordIds, storyType: $storyType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryResponseImpl &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.narrative, narrative) ||
                other.narrative == narrative) &&
            const DeepCollectionEquality().equals(other._wordIds, _wordIds) &&
            (identical(other.storyType, storyType) ||
                other.storyType == storyType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storyId, title, narrative,
      const DeepCollectionEquality().hash(_wordIds), storyType);

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryResponseImplCopyWith<_$StoryResponseImpl> get copyWith =>
      __$$StoryResponseImplCopyWithImpl<_$StoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryResponseImplToJson(
      this,
    );
  }
}

abstract class _StoryResponse implements StoryResponse {
  const factory _StoryResponse(
          {@JsonKey(name: 'story_id') required final int storyId,
          required final String title,
          required final String narrative,
          @JsonKey(name: 'word_ids') required final List<int> wordIds,
          @JsonKey(name: 'story_type') required final String storyType}) =
      _$StoryResponseImpl;

  factory _StoryResponse.fromJson(Map<String, dynamic> json) =
      _$StoryResponseImpl.fromJson;

  @override
  @JsonKey(name: 'story_id')
  int get storyId;
  @override
  String get title;
  @override
  String get narrative;
  @override
  @JsonKey(name: 'word_ids')
  List<int> get wordIds;
  @override
  @JsonKey(name: 'story_type')
  String get storyType;

  /// Create a copy of StoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryResponseImplCopyWith<_$StoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRequest _$ChatRequestFromJson(Map<String, dynamic> json) {
  return _ChatRequest.fromJson(json);
}

/// @nodoc
mixin _$ChatRequest {
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ChatRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRequestCopyWith<ChatRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRequestCopyWith<$Res> {
  factory $ChatRequestCopyWith(
          ChatRequest value, $Res Function(ChatRequest) then) =
      _$ChatRequestCopyWithImpl<$Res, ChatRequest>;
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId, String message});
}

/// @nodoc
class _$ChatRequestCopyWithImpl<$Res, $Val extends ChatRequest>
    implements $ChatRequestCopyWith<$Res> {
  _$ChatRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRequestImplCopyWith<$Res>
    implements $ChatRequestCopyWith<$Res> {
  factory _$$ChatRequestImplCopyWith(
          _$ChatRequestImpl value, $Res Function(_$ChatRequestImpl) then) =
      __$$ChatRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'word_id') int wordId, String message});
}

/// @nodoc
class __$$ChatRequestImplCopyWithImpl<$Res>
    extends _$ChatRequestCopyWithImpl<$Res, _$ChatRequestImpl>
    implements _$$ChatRequestImplCopyWith<$Res> {
  __$$ChatRequestImplCopyWithImpl(
      _$ChatRequestImpl _value, $Res Function(_$ChatRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordId = null,
    Object? message = null,
  }) {
    return _then(_$ChatRequestImpl(
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRequestImpl implements _ChatRequest {
  const _$ChatRequestImpl(
      {@JsonKey(name: 'word_id') required this.wordId, required this.message});

  factory _$ChatRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRequestImplFromJson(json);

  @override
  @JsonKey(name: 'word_id')
  final int wordId;
  @override
  final String message;

  @override
  String toString() {
    return 'ChatRequest(wordId: $wordId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRequestImpl &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wordId, message);

  /// Create a copy of ChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRequestImplCopyWith<_$ChatRequestImpl> get copyWith =>
      __$$ChatRequestImplCopyWithImpl<_$ChatRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRequestImplToJson(
      this,
    );
  }
}

abstract class _ChatRequest implements ChatRequest {
  const factory _ChatRequest(
      {@JsonKey(name: 'word_id') required final int wordId,
      required final String message}) = _$ChatRequestImpl;

  factory _ChatRequest.fromJson(Map<String, dynamic> json) =
      _$ChatRequestImpl.fromJson;

  @override
  @JsonKey(name: 'word_id')
  int get wordId;
  @override
  String get message;

  /// Create a copy of ChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRequestImplCopyWith<_$ChatRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) {
  return _ChatResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatResponse {
  String get response => throw _privateConstructorUsedError;

  /// Serializes this ChatResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatResponseCopyWith<ChatResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatResponseCopyWith<$Res> {
  factory $ChatResponseCopyWith(
          ChatResponse value, $Res Function(ChatResponse) then) =
      _$ChatResponseCopyWithImpl<$Res, ChatResponse>;
  @useResult
  $Res call({String response});
}

/// @nodoc
class _$ChatResponseCopyWithImpl<$Res, $Val extends ChatResponse>
    implements $ChatResponseCopyWith<$Res> {
  _$ChatResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatResponseImplCopyWith<$Res>
    implements $ChatResponseCopyWith<$Res> {
  factory _$$ChatResponseImplCopyWith(
          _$ChatResponseImpl value, $Res Function(_$ChatResponseImpl) then) =
      __$$ChatResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String response});
}

/// @nodoc
class __$$ChatResponseImplCopyWithImpl<$Res>
    extends _$ChatResponseCopyWithImpl<$Res, _$ChatResponseImpl>
    implements _$$ChatResponseImplCopyWith<$Res> {
  __$$ChatResponseImplCopyWithImpl(
      _$ChatResponseImpl _value, $Res Function(_$ChatResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$ChatResponseImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatResponseImpl implements _ChatResponse {
  const _$ChatResponseImpl({required this.response});

  factory _$ChatResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatResponseImplFromJson(json);

  @override
  final String response;

  @override
  String toString() {
    return 'ChatResponse(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatResponseImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatResponseImplCopyWith<_$ChatResponseImpl> get copyWith =>
      __$$ChatResponseImplCopyWithImpl<_$ChatResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatResponse implements ChatResponse {
  const factory _ChatResponse({required final String response}) =
      _$ChatResponseImpl;

  factory _ChatResponse.fromJson(Map<String, dynamic> json) =
      _$ChatResponseImpl.fromJson;

  @override
  String get response;

  /// Create a copy of ChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatResponseImplCopyWith<_$ChatResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
