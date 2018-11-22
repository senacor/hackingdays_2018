// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

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

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'loyaltyCards',
      serializers.serialize(object.loyaltyCards,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(LoyaltyCard)])),
      'onboarding',
      serializers.serialize(object.onboarding,
          specifiedType: const FullType(Onboarding)),
    ];
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(User)));
    }

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'loyaltyCards':
          result.loyaltyCards.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(LoyaltyCard)
              ])) as BuiltMap);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'onboarding':
          result.onboarding.replace(serializers.deserialize(value,
              specifiedType: const FullType(Onboarding)) as Onboarding);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final BuiltMap<String, LoyaltyCard> loyaltyCards;
  @override
  final User user;
  @override
  final Onboarding onboarding;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.loyaltyCards, this.user, this.onboarding}) : super._() {
    if (loyaltyCards == null) {
      throw new BuiltValueNullFieldError('AppState', 'loyaltyCards');
    }
    if (onboarding == null) {
      throw new BuiltValueNullFieldError('AppState', 'onboarding');
    }
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        loyaltyCards == other.loyaltyCards &&
        user == other.user &&
        onboarding == other.onboarding;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, loyaltyCards.hashCode), user.hashCode),
        onboarding.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('loyaltyCards', loyaltyCards)
          ..add('user', user)
          ..add('onboarding', onboarding))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  MapBuilder<String, LoyaltyCard> _loyaltyCards;
  MapBuilder<String, LoyaltyCard> get loyaltyCards =>
      _$this._loyaltyCards ??= new MapBuilder<String, LoyaltyCard>();
  set loyaltyCards(MapBuilder<String, LoyaltyCard> loyaltyCards) =>
      _$this._loyaltyCards = loyaltyCards;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  OnboardingBuilder _onboarding;
  OnboardingBuilder get onboarding =>
      _$this._onboarding ??= new OnboardingBuilder();
  set onboarding(OnboardingBuilder onboarding) =>
      _$this._onboarding = onboarding;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _loyaltyCards = _$v.loyaltyCards?.toBuilder();
      _user = _$v.user?.toBuilder();
      _onboarding = _$v.onboarding?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              loyaltyCards: loyaltyCards.build(),
              user: _user?.build(),
              onboarding: onboarding.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'loyaltyCards';
        loyaltyCards.build();
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'onboarding';
        onboarding.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
