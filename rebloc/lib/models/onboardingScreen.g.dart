// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboardingScreen.dart';

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

Serializer<OnboardingScreen> _$onboardingScreenSerializer =
    new _$OnboardingScreenSerializer();

class _$OnboardingScreenSerializer
    implements StructuredSerializer<OnboardingScreen> {
  @override
  final Iterable<Type> types = const [OnboardingScreen, _$OnboardingScreen];
  @override
  final String wireName = 'OnboardingScreen';

  @override
  Iterable serialize(Serializers serializers, OnboardingScreen object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'isOnboardingRequestRunning',
      serializers.serialize(object.isOnboardingRequestRunning,
          specifiedType: const FullType(bool)),
    ];
    if (object.onboardingRequestErrorMessage != null) {
      result
        ..add('onboardingRequestErrorMessage')
        ..add(serializers.serialize(object.onboardingRequestErrorMessage,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  OnboardingScreen deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OnboardingScreenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isOnboardingRequestRunning':
          result.isOnboardingRequestRunning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'onboardingRequestErrorMessage':
          result.onboardingRequestErrorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OnboardingScreen extends OnboardingScreen {
  @override
  final bool isOnboardingRequestRunning;
  @override
  final String onboardingRequestErrorMessage;

  factory _$OnboardingScreen([void updates(OnboardingScreenBuilder b)]) =>
      (new OnboardingScreenBuilder()..update(updates)).build()
          as _$OnboardingScreen;

  _$OnboardingScreen._(
      {this.isOnboardingRequestRunning, this.onboardingRequestErrorMessage})
      : super._() {
    if (isOnboardingRequestRunning == null) {
      throw new BuiltValueNullFieldError(
          'OnboardingScreen', 'isOnboardingRequestRunning');
    }
  }

  @override
  OnboardingScreen rebuild(void updates(OnboardingScreenBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$OnboardingScreenBuilder toBuilder() =>
      new _$OnboardingScreenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnboardingScreen &&
        isOnboardingRequestRunning == other.isOnboardingRequestRunning &&
        onboardingRequestErrorMessage == other.onboardingRequestErrorMessage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, isOnboardingRequestRunning.hashCode),
        onboardingRequestErrorMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OnboardingScreen')
          ..add('isOnboardingRequestRunning', isOnboardingRequestRunning)
          ..add('onboardingRequestErrorMessage', onboardingRequestErrorMessage))
        .toString();
  }
}

class _$OnboardingScreenBuilder extends OnboardingScreenBuilder {
  _$OnboardingScreen _$v;

  @override
  bool get isOnboardingRequestRunning {
    _$this;
    return super.isOnboardingRequestRunning;
  }

  @override
  set isOnboardingRequestRunning(bool isOnboardingRequestRunning) {
    _$this;
    super.isOnboardingRequestRunning = isOnboardingRequestRunning;
  }

  @override
  String get onboardingRequestErrorMessage {
    _$this;
    return super.onboardingRequestErrorMessage;
  }

  @override
  set onboardingRequestErrorMessage(String onboardingRequestErrorMessage) {
    _$this;
    super.onboardingRequestErrorMessage = onboardingRequestErrorMessage;
  }

  _$OnboardingScreenBuilder() : super._();

  OnboardingScreenBuilder get _$this {
    if (_$v != null) {
      super.isOnboardingRequestRunning = _$v.isOnboardingRequestRunning;
      super.onboardingRequestErrorMessage = _$v.onboardingRequestErrorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnboardingScreen other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OnboardingScreen;
  }

  @override
  void update(void updates(OnboardingScreenBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$OnboardingScreen build() {
    final _$result = _$v ??
        new _$OnboardingScreen._(
            isOnboardingRequestRunning: isOnboardingRequestRunning,
            onboardingRequestErrorMessage: onboardingRequestErrorMessage);
    replace(_$result);
    return _$result;
  }
}
