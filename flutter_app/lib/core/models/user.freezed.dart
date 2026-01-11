// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_level')
  double? get currentLevel =>
      throw _privateConstructorUsedError; // Nullable double - null means not assessed yet
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_active')
  String? get lastActive => throw _privateConstructorUsedError;
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {int id,
      String email,
      String username,
      @JsonKey(name: 'current_level') double? currentLevel,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'last_active') String? lastActive,
      Map<String, dynamic> settings});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? currentLevel = freezed,
    Object? createdAt = null,
    Object? lastActive = freezed,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String username,
      @JsonKey(name: 'current_level') double? currentLevel,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'last_active') String? lastActive,
      Map<String, dynamic> settings});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? currentLevel = freezed,
    Object? createdAt = null,
    Object? lastActive = freezed,
    Object? settings = null,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.id,
      required this.email,
      required this.username,
      @JsonKey(name: 'current_level') this.currentLevel,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'last_active') this.lastActive,
      final Map<String, dynamic> settings = const {}})
      : _settings = settings;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String username;
  @override
  @JsonKey(name: 'current_level')
  final double? currentLevel;
// Nullable double - null means not assessed yet
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'last_active')
  final String? lastActive;
  final Map<String, dynamic> _settings;
  @override
  @JsonKey()
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, username: $username, currentLevel: $currentLevel, createdAt: $createdAt, lastActive: $lastActive, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      username,
      currentLevel,
      createdAt,
      lastActive,
      const DeepCollectionEquality().hash(_settings));

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final int id,
      required final String email,
      required final String username,
      @JsonKey(name: 'current_level') final double? currentLevel,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'last_active') final String? lastActive,
      final Map<String, dynamic> settings}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get username;
  @override
  @JsonKey(name: 'current_level')
  double? get currentLevel; // Nullable double - null means not assessed yet
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'last_active')
  String? get lastActive;
  @override
  Map<String, dynamic> get settings;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) {
  return _UserRegister.fromJson(json);
}

/// @nodoc
mixin _$UserRegister {
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this UserRegister to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRegister
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRegisterCopyWith<UserRegister> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRegisterCopyWith<$Res> {
  factory $UserRegisterCopyWith(
          UserRegister value, $Res Function(UserRegister) then) =
      _$UserRegisterCopyWithImpl<$Res, UserRegister>;
  @useResult
  $Res call({String email, String username, String password});
}

/// @nodoc
class _$UserRegisterCopyWithImpl<$Res, $Val extends UserRegister>
    implements $UserRegisterCopyWith<$Res> {
  _$UserRegisterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRegister
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserRegisterImplCopyWith<$Res>
    implements $UserRegisterCopyWith<$Res> {
  factory _$$UserRegisterImplCopyWith(
          _$UserRegisterImpl value, $Res Function(_$UserRegisterImpl) then) =
      __$$UserRegisterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String username, String password});
}

/// @nodoc
class __$$UserRegisterImplCopyWithImpl<$Res>
    extends _$UserRegisterCopyWithImpl<$Res, _$UserRegisterImpl>
    implements _$$UserRegisterImplCopyWith<$Res> {
  __$$UserRegisterImplCopyWithImpl(
      _$UserRegisterImpl _value, $Res Function(_$UserRegisterImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRegister
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$UserRegisterImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRegisterImpl implements _UserRegister {
  const _$UserRegisterImpl(
      {required this.email, required this.username, required this.password});

  factory _$UserRegisterImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRegisterImplFromJson(json);

  @override
  final String email;
  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'UserRegister(email: $email, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRegisterImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, username, password);

  /// Create a copy of UserRegister
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRegisterImplCopyWith<_$UserRegisterImpl> get copyWith =>
      __$$UserRegisterImplCopyWithImpl<_$UserRegisterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRegisterImplToJson(
      this,
    );
  }
}

abstract class _UserRegister implements UserRegister {
  const factory _UserRegister(
      {required final String email,
      required final String username,
      required final String password}) = _$UserRegisterImpl;

  factory _UserRegister.fromJson(Map<String, dynamic> json) =
      _$UserRegisterImpl.fromJson;

  @override
  String get email;
  @override
  String get username;
  @override
  String get password;

  /// Create a copy of UserRegister
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRegisterImplCopyWith<_$UserRegisterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) {
  return _UserLogin.fromJson(json);
}

/// @nodoc
mixin _$UserLogin {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this UserLogin to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserLogin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLoginCopyWith<UserLogin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLoginCopyWith<$Res> {
  factory $UserLoginCopyWith(UserLogin value, $Res Function(UserLogin) then) =
      _$UserLoginCopyWithImpl<$Res, UserLogin>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$UserLoginCopyWithImpl<$Res, $Val extends UserLogin>
    implements $UserLoginCopyWith<$Res> {
  _$UserLoginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLogin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserLoginImplCopyWith<$Res>
    implements $UserLoginCopyWith<$Res> {
  factory _$$UserLoginImplCopyWith(
          _$UserLoginImpl value, $Res Function(_$UserLoginImpl) then) =
      __$$UserLoginImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$UserLoginImplCopyWithImpl<$Res>
    extends _$UserLoginCopyWithImpl<$Res, _$UserLoginImpl>
    implements _$$UserLoginImplCopyWith<$Res> {
  __$$UserLoginImplCopyWithImpl(
      _$UserLoginImpl _value, $Res Function(_$UserLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserLogin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$UserLoginImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLoginImpl implements _UserLogin {
  const _$UserLoginImpl({required this.email, required this.password});

  factory _$UserLoginImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLoginImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'UserLogin(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLoginImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of UserLogin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLoginImplCopyWith<_$UserLoginImpl> get copyWith =>
      __$$UserLoginImplCopyWithImpl<_$UserLoginImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLoginImplToJson(
      this,
    );
  }
}

abstract class _UserLogin implements UserLogin {
  const factory _UserLogin(
      {required final String email,
      required final String password}) = _$UserLoginImpl;

  factory _UserLogin.fromJson(Map<String, dynamic> json) =
      _$UserLoginImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of UserLogin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLoginImplCopyWith<_$UserLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return _TokenResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenResponse {
  @JsonKey(name: 'access_token')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type')
  String get tokenType => throw _privateConstructorUsedError;

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
          TokenResponse value, $Res Function(TokenResponse) then) =
      _$TokenResponseCopyWithImpl<$Res, TokenResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'token_type') String tokenType});
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res, $Val extends TokenResponse>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenResponseImplCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$$TokenResponseImplCopyWith(
          _$TokenResponseImpl value, $Res Function(_$TokenResponseImpl) then) =
      __$$TokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'token_type') String tokenType});
}

/// @nodoc
class __$$TokenResponseImplCopyWithImpl<$Res>
    extends _$TokenResponseCopyWithImpl<$Res, _$TokenResponseImpl>
    implements _$$TokenResponseImplCopyWith<$Res> {
  __$$TokenResponseImplCopyWithImpl(
      _$TokenResponseImpl _value, $Res Function(_$TokenResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
  }) {
    return _then(_$TokenResponseImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseImpl implements _TokenResponse {
  const _$TokenResponseImpl(
      {@JsonKey(name: 'access_token') required this.accessToken,
      @JsonKey(name: 'token_type') this.tokenType = 'bearer'});

  factory _$TokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseImplFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  @JsonKey(name: 'token_type')
  final String tokenType;

  @override
  String toString() {
    return 'TokenResponse(accessToken: $accessToken, tokenType: $tokenType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, tokenType);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      __$$TokenResponseImplCopyWithImpl<_$TokenResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseImplToJson(
      this,
    );
  }
}

abstract class _TokenResponse implements TokenResponse {
  const factory _TokenResponse(
          {@JsonKey(name: 'access_token') required final String accessToken,
          @JsonKey(name: 'token_type') final String tokenType}) =
      _$TokenResponseImpl;

  factory _TokenResponse.fromJson(Map<String, dynamic> json) =
      _$TokenResponseImpl.fromJson;

  @override
  @JsonKey(name: 'access_token')
  String get accessToken;
  @override
  @JsonKey(name: 'token_type')
  String get tokenType;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfileUpdate _$UserProfileUpdateFromJson(Map<String, dynamic> json) {
  return _UserProfileUpdate.fromJson(json);
}

/// @nodoc
mixin _$UserProfileUpdate {
  String? get username => throw _privateConstructorUsedError;
  double? get currentLevel =>
      throw _privateConstructorUsedError; // Double instead of String
  Map<String, dynamic>? get settings => throw _privateConstructorUsedError;

  /// Serializes this UserProfileUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileUpdateCopyWith<UserProfileUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileUpdateCopyWith<$Res> {
  factory $UserProfileUpdateCopyWith(
          UserProfileUpdate value, $Res Function(UserProfileUpdate) then) =
      _$UserProfileUpdateCopyWithImpl<$Res, UserProfileUpdate>;
  @useResult
  $Res call(
      {String? username, double? currentLevel, Map<String, dynamic>? settings});
}

/// @nodoc
class _$UserProfileUpdateCopyWithImpl<$Res, $Val extends UserProfileUpdate>
    implements $UserProfileUpdateCopyWith<$Res> {
  _$UserProfileUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? currentLevel = freezed,
    Object? settings = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileUpdateImplCopyWith<$Res>
    implements $UserProfileUpdateCopyWith<$Res> {
  factory _$$UserProfileUpdateImplCopyWith(_$UserProfileUpdateImpl value,
          $Res Function(_$UserProfileUpdateImpl) then) =
      __$$UserProfileUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? username, double? currentLevel, Map<String, dynamic>? settings});
}

/// @nodoc
class __$$UserProfileUpdateImplCopyWithImpl<$Res>
    extends _$UserProfileUpdateCopyWithImpl<$Res, _$UserProfileUpdateImpl>
    implements _$$UserProfileUpdateImplCopyWith<$Res> {
  __$$UserProfileUpdateImplCopyWithImpl(_$UserProfileUpdateImpl _value,
      $Res Function(_$UserProfileUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? currentLevel = freezed,
    Object? settings = freezed,
  }) {
    return _then(_$UserProfileUpdateImpl(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      settings: freezed == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileUpdateImpl implements _UserProfileUpdate {
  const _$UserProfileUpdateImpl(
      {this.username, this.currentLevel, final Map<String, dynamic>? settings})
      : _settings = settings;

  factory _$UserProfileUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileUpdateImplFromJson(json);

  @override
  final String? username;
  @override
  final double? currentLevel;
// Double instead of String
  final Map<String, dynamic>? _settings;
// Double instead of String
  @override
  Map<String, dynamic>? get settings {
    final value = _settings;
    if (value == null) return null;
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UserProfileUpdate(username: $username, currentLevel: $currentLevel, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileUpdateImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, currentLevel,
      const DeepCollectionEquality().hash(_settings));

  /// Create a copy of UserProfileUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileUpdateImplCopyWith<_$UserProfileUpdateImpl> get copyWith =>
      __$$UserProfileUpdateImplCopyWithImpl<_$UserProfileUpdateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileUpdateImplToJson(
      this,
    );
  }
}

abstract class _UserProfileUpdate implements UserProfileUpdate {
  const factory _UserProfileUpdate(
      {final String? username,
      final double? currentLevel,
      final Map<String, dynamic>? settings}) = _$UserProfileUpdateImpl;

  factory _UserProfileUpdate.fromJson(Map<String, dynamic> json) =
      _$UserProfileUpdateImpl.fromJson;

  @override
  String? get username;
  @override
  double? get currentLevel; // Double instead of String
  @override
  Map<String, dynamic>? get settings;

  /// Create a copy of UserProfileUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileUpdateImplCopyWith<_$UserProfileUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  @JsonKey(name: 'total_words')
  int get totalWords => throw _privateConstructorUsedError;
  @JsonKey(name: 'mastered_words')
  int get masteredWords => throw _privateConstructorUsedError;
  @JsonKey(name: 'learning_words')
  int get learningWords => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewing_words')
  int get reviewingWords => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quizzes')
  int get totalQuizzes => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  int get correctAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'accuracy_rate')
  double get accuracyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'words_due_today')
  int get wordsDueToday => throw _privateConstructorUsedError;

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_words') int totalWords,
      @JsonKey(name: 'mastered_words') int masteredWords,
      @JsonKey(name: 'learning_words') int learningWords,
      @JsonKey(name: 'reviewing_words') int reviewingWords,
      @JsonKey(name: 'total_quizzes') int totalQuizzes,
      @JsonKey(name: 'correct_answers') int correctAnswers,
      @JsonKey(name: 'accuracy_rate') double accuracyRate,
      @JsonKey(name: 'words_due_today') int wordsDueToday});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalWords = null,
    Object? masteredWords = null,
    Object? learningWords = null,
    Object? reviewingWords = null,
    Object? totalQuizzes = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
    Object? wordsDueToday = null,
  }) {
    return _then(_value.copyWith(
      totalWords: null == totalWords
          ? _value.totalWords
          : totalWords // ignore: cast_nullable_to_non_nullable
              as int,
      masteredWords: null == masteredWords
          ? _value.masteredWords
          : masteredWords // ignore: cast_nullable_to_non_nullable
              as int,
      learningWords: null == learningWords
          ? _value.learningWords
          : learningWords // ignore: cast_nullable_to_non_nullable
              as int,
      reviewingWords: null == reviewingWords
          ? _value.reviewingWords
          : reviewingWords // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuizzes: null == totalQuizzes
          ? _value.totalQuizzes
          : totalQuizzes // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      accuracyRate: null == accuracyRate
          ? _value.accuracyRate
          : accuracyRate // ignore: cast_nullable_to_non_nullable
              as double,
      wordsDueToday: null == wordsDueToday
          ? _value.wordsDueToday
          : wordsDueToday // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
          _$UserStatsImpl value, $Res Function(_$UserStatsImpl) then) =
      __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_words') int totalWords,
      @JsonKey(name: 'mastered_words') int masteredWords,
      @JsonKey(name: 'learning_words') int learningWords,
      @JsonKey(name: 'reviewing_words') int reviewingWords,
      @JsonKey(name: 'total_quizzes') int totalQuizzes,
      @JsonKey(name: 'correct_answers') int correctAnswers,
      @JsonKey(name: 'accuracy_rate') double accuracyRate,
      @JsonKey(name: 'words_due_today') int wordsDueToday});
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
      _$UserStatsImpl _value, $Res Function(_$UserStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalWords = null,
    Object? masteredWords = null,
    Object? learningWords = null,
    Object? reviewingWords = null,
    Object? totalQuizzes = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
    Object? wordsDueToday = null,
  }) {
    return _then(_$UserStatsImpl(
      totalWords: null == totalWords
          ? _value.totalWords
          : totalWords // ignore: cast_nullable_to_non_nullable
              as int,
      masteredWords: null == masteredWords
          ? _value.masteredWords
          : masteredWords // ignore: cast_nullable_to_non_nullable
              as int,
      learningWords: null == learningWords
          ? _value.learningWords
          : learningWords // ignore: cast_nullable_to_non_nullable
              as int,
      reviewingWords: null == reviewingWords
          ? _value.reviewingWords
          : reviewingWords // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuizzes: null == totalQuizzes
          ? _value.totalQuizzes
          : totalQuizzes // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      accuracyRate: null == accuracyRate
          ? _value.accuracyRate
          : accuracyRate // ignore: cast_nullable_to_non_nullable
              as double,
      wordsDueToday: null == wordsDueToday
          ? _value.wordsDueToday
          : wordsDueToday // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl(
      {@JsonKey(name: 'total_words') required this.totalWords,
      @JsonKey(name: 'mastered_words') required this.masteredWords,
      @JsonKey(name: 'learning_words') required this.learningWords,
      @JsonKey(name: 'reviewing_words') required this.reviewingWords,
      @JsonKey(name: 'total_quizzes') required this.totalQuizzes,
      @JsonKey(name: 'correct_answers') required this.correctAnswers,
      @JsonKey(name: 'accuracy_rate') required this.accuracyRate,
      @JsonKey(name: 'words_due_today') required this.wordsDueToday});

  factory _$UserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_words')
  final int totalWords;
  @override
  @JsonKey(name: 'mastered_words')
  final int masteredWords;
  @override
  @JsonKey(name: 'learning_words')
  final int learningWords;
  @override
  @JsonKey(name: 'reviewing_words')
  final int reviewingWords;
  @override
  @JsonKey(name: 'total_quizzes')
  final int totalQuizzes;
  @override
  @JsonKey(name: 'correct_answers')
  final int correctAnswers;
  @override
  @JsonKey(name: 'accuracy_rate')
  final double accuracyRate;
  @override
  @JsonKey(name: 'words_due_today')
  final int wordsDueToday;

  @override
  String toString() {
    return 'UserStats(totalWords: $totalWords, masteredWords: $masteredWords, learningWords: $learningWords, reviewingWords: $reviewingWords, totalQuizzes: $totalQuizzes, correctAnswers: $correctAnswers, accuracyRate: $accuracyRate, wordsDueToday: $wordsDueToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.totalWords, totalWords) ||
                other.totalWords == totalWords) &&
            (identical(other.masteredWords, masteredWords) ||
                other.masteredWords == masteredWords) &&
            (identical(other.learningWords, learningWords) ||
                other.learningWords == learningWords) &&
            (identical(other.reviewingWords, reviewingWords) ||
                other.reviewingWords == reviewingWords) &&
            (identical(other.totalQuizzes, totalQuizzes) ||
                other.totalQuizzes == totalQuizzes) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.accuracyRate, accuracyRate) ||
                other.accuracyRate == accuracyRate) &&
            (identical(other.wordsDueToday, wordsDueToday) ||
                other.wordsDueToday == wordsDueToday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalWords,
      masteredWords,
      learningWords,
      reviewingWords,
      totalQuizzes,
      correctAnswers,
      accuracyRate,
      wordsDueToday);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsImplToJson(
      this,
    );
  }
}

abstract class _UserStats implements UserStats {
  const factory _UserStats(
          {@JsonKey(name: 'total_words') required final int totalWords,
          @JsonKey(name: 'mastered_words') required final int masteredWords,
          @JsonKey(name: 'learning_words') required final int learningWords,
          @JsonKey(name: 'reviewing_words') required final int reviewingWords,
          @JsonKey(name: 'total_quizzes') required final int totalQuizzes,
          @JsonKey(name: 'correct_answers') required final int correctAnswers,
          @JsonKey(name: 'accuracy_rate') required final double accuracyRate,
          @JsonKey(name: 'words_due_today') required final int wordsDueToday}) =
      _$UserStatsImpl;

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$UserStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_words')
  int get totalWords;
  @override
  @JsonKey(name: 'mastered_words')
  int get masteredWords;
  @override
  @JsonKey(name: 'learning_words')
  int get learningWords;
  @override
  @JsonKey(name: 'reviewing_words')
  int get reviewingWords;
  @override
  @JsonKey(name: 'total_quizzes')
  int get totalQuizzes;
  @override
  @JsonKey(name: 'correct_answers')
  int get correctAnswers;
  @override
  @JsonKey(name: 'accuracy_rate')
  double get accuracyRate;
  @override
  @JsonKey(name: 'words_due_today')
  int get wordsDueToday;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
