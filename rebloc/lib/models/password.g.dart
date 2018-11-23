// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

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

Serializer<Password> _$passwordSerializer = new _$PasswordSerializer();

class _$PasswordSerializer implements StructuredSerializer<Password> {
  @override
  final Iterable<Type> types = const [Password, _$Password];
  @override
  final String wireName = 'Password';

  @override
  Iterable serialize(Serializers serializers, Password object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Password deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PasswordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Password extends Password {
  @override
  final String password;

  factory _$Password([void updates(PasswordBuilder b)]) =>
      (new PasswordBuilder()..update(updates)).build();

  _$Password._({this.password}) : super._() {
    if (password == null) {
      throw new BuiltValueNullFieldError('Password', 'password');
    }
  }

  @override
  Password rebuild(void updates(PasswordBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordBuilder toBuilder() => new PasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Password && password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc(0, password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Password')..add('password', password))
        .toString();
  }
}

class PasswordBuilder implements Builder<Password, PasswordBuilder> {
  _$Password _$v;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  PasswordBuilder();

  PasswordBuilder get _$this {
    if (_$v != null) {
      _password = _$v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Password other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Password;
  }

  @override
  void update(void updates(PasswordBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Password build() {
    final _$result = _$v ?? new _$Password._(password: password);
    replace(_$result);
    return _$result;
  }
}
