// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboardingResponse.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<OnboardingResponse> _$onboardingResponseSerializer =
    new _$OnboardingResponseSerializer();
Serializer<OnboardedUser> _$onboardedUserSerializer =
    new _$OnboardedUserSerializer();
Serializer<Auth> _$authSerializer = new _$AuthSerializer();

class _$OnboardingResponseSerializer
    implements StructuredSerializer<OnboardingResponse> {
  @override
  final Iterable<Type> types = const [OnboardingResponse, _$OnboardingResponse];
  @override
  final String wireName = 'OnboardingResponse';

  @override
  Iterable serialize(Serializers serializers, OnboardingResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'onboardedUser',
      serializers.serialize(object.onboardedUser,
          specifiedType: const FullType(OnboardedUser)),
      'auth',
      serializers.serialize(object.auth, specifiedType: const FullType(Auth)),
    ];

    return result;
  }

  @override
  OnboardingResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OnboardingResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'onboardedUser':
          result.onboardedUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(OnboardedUser)) as OnboardedUser);
          break;
        case 'auth':
          result.auth.replace(serializers.deserialize(value,
              specifiedType: const FullType(Auth)) as Auth);
          break;
      }
    }

    return result.build();
  }
}

class _$OnboardedUserSerializer implements StructuredSerializer<OnboardedUser> {
  @override
  final Iterable<Type> types = const [OnboardedUser, _$OnboardedUser];
  @override
  final String wireName = 'OnboardedUser';

  @override
  Iterable serialize(Serializers serializers, OnboardedUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'nickname',
      serializers.serialize(object.nickname,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  OnboardedUser deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OnboardedUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nickname':
          result.nickname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthSerializer implements StructuredSerializer<Auth> {
  @override
  final Iterable<Type> types = const [Auth, _$Auth];
  @override
  final String wireName = 'Auth';

  @override
  Iterable serialize(Serializers serializers, Auth object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
      'clientId',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Auth deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'clientId':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OnboardingResponse extends OnboardingResponse {
  @override
  final OnboardedUser onboardedUser;
  @override
  final Auth auth;

  factory _$OnboardingResponse([void updates(OnboardingResponseBuilder b)]) =>
      (new OnboardingResponseBuilder()..update(updates)).build();

  _$OnboardingResponse._({this.onboardedUser, this.auth}) : super._() {
    if (onboardedUser == null) {
      throw new BuiltValueNullFieldError('OnboardingResponse', 'onboardedUser');
    }
    if (auth == null) {
      throw new BuiltValueNullFieldError('OnboardingResponse', 'auth');
    }
  }

  @override
  OnboardingResponse rebuild(void updates(OnboardingResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  OnboardingResponseBuilder toBuilder() =>
      new OnboardingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnboardingResponse &&
        onboardedUser == other.onboardedUser &&
        auth == other.auth;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, onboardedUser.hashCode), auth.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OnboardingResponse')
          ..add('onboardedUser', onboardedUser)
          ..add('auth', auth))
        .toString();
  }
}

class OnboardingResponseBuilder
    implements Builder<OnboardingResponse, OnboardingResponseBuilder> {
  _$OnboardingResponse _$v;

  OnboardedUserBuilder _onboardedUser;
  OnboardedUserBuilder get onboardedUser =>
      _$this._onboardedUser ??= new OnboardedUserBuilder();
  set onboardedUser(OnboardedUserBuilder onboardedUser) =>
      _$this._onboardedUser = onboardedUser;

  AuthBuilder _auth;
  AuthBuilder get auth => _$this._auth ??= new AuthBuilder();
  set auth(AuthBuilder auth) => _$this._auth = auth;

  OnboardingResponseBuilder();

  OnboardingResponseBuilder get _$this {
    if (_$v != null) {
      _onboardedUser = _$v.onboardedUser?.toBuilder();
      _auth = _$v.auth?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnboardingResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OnboardingResponse;
  }

  @override
  void update(void updates(OnboardingResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$OnboardingResponse build() {
    _$OnboardingResponse _$result;
    try {
      _$result = _$v ??
          new _$OnboardingResponse._(
              onboardedUser: onboardedUser.build(), auth: auth.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'onboardedUser';
        onboardedUser.build();
        _$failedField = 'auth';
        auth.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OnboardingResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$OnboardedUser extends OnboardedUser {
  @override
  final String userId;
  @override
  final String nickname;
  @override
  final String status;

  factory _$OnboardedUser([void updates(OnboardedUserBuilder b)]) =>
      (new OnboardedUserBuilder()..update(updates)).build();

  _$OnboardedUser._({this.userId, this.nickname, this.status}) : super._() {
    if (userId == null) {
      throw new BuiltValueNullFieldError('OnboardedUser', 'userId');
    }
    if (nickname == null) {
      throw new BuiltValueNullFieldError('OnboardedUser', 'nickname');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('OnboardedUser', 'status');
    }
  }

  @override
  OnboardedUser rebuild(void updates(OnboardedUserBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  OnboardedUserBuilder toBuilder() => new OnboardedUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnboardedUser &&
        userId == other.userId &&
        nickname == other.nickname &&
        status == other.status;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, userId.hashCode), nickname.hashCode), status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OnboardedUser')
          ..add('userId', userId)
          ..add('nickname', nickname)
          ..add('status', status))
        .toString();
  }
}

class OnboardedUserBuilder
    implements Builder<OnboardedUser, OnboardedUserBuilder> {
  _$OnboardedUser _$v;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _nickname;
  String get nickname => _$this._nickname;
  set nickname(String nickname) => _$this._nickname = nickname;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  OnboardedUserBuilder();

  OnboardedUserBuilder get _$this {
    if (_$v != null) {
      _userId = _$v.userId;
      _nickname = _$v.nickname;
      _status = _$v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnboardedUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OnboardedUser;
  }

  @override
  void update(void updates(OnboardedUserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$OnboardedUser build() {
    final _$result = _$v ??
        new _$OnboardedUser._(
            userId: userId, nickname: nickname, status: status);
    replace(_$result);
    return _$result;
  }
}

class _$Auth extends Auth {
  @override
  final String username;
  @override
  final String password;
  @override
  final String clientId;

  factory _$Auth([void updates(AuthBuilder b)]) =>
      (new AuthBuilder()..update(updates)).build();

  _$Auth._({this.username, this.password, this.clientId}) : super._() {
    if (username == null) {
      throw new BuiltValueNullFieldError('Auth', 'username');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('Auth', 'password');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('Auth', 'clientId');
    }
  }

  @override
  Auth rebuild(void updates(AuthBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthBuilder toBuilder() => new AuthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Auth &&
        username == other.username &&
        password == other.password &&
        clientId == other.clientId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, username.hashCode), password.hashCode), clientId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Auth')
          ..add('username', username)
          ..add('password', password)
          ..add('clientId', clientId))
        .toString();
  }
}

class AuthBuilder implements Builder<Auth, AuthBuilder> {
  _$Auth _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  AuthBuilder();

  AuthBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
      _password = _$v.password;
      _clientId = _$v.clientId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Auth other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Auth;
  }

  @override
  void update(void updates(AuthBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Auth build() {
    final _$result = _$v ??
        new _$Auth._(
            username: username, password: password, clientId: clientId);
    replace(_$result);
    return _$result;
  }
}
