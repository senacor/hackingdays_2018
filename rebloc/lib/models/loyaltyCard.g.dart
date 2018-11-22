// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyaltyCard.dart';

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

Serializer<LoyaltyCard> _$loyaltyCardSerializer = new _$LoyaltyCardSerializer();

class _$LoyaltyCardSerializer implements StructuredSerializer<LoyaltyCard> {
  @override
  final Iterable<Type> types = const [LoyaltyCard, _$LoyaltyCard];
  @override
  final String wireName = 'LoyaltyCard';

  @override
  Iterable serialize(Serializers serializers, LoyaltyCard object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'cardId',
      serializers.serialize(object.cardId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  LoyaltyCard deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoyaltyCardBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cardId':
          result.cardId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LoyaltyCard extends LoyaltyCard {
  @override
  final String name;
  @override
  final String cardId;

  factory _$LoyaltyCard([void updates(LoyaltyCardBuilder b)]) =>
      (new LoyaltyCardBuilder()..update(updates)).build();

  _$LoyaltyCard._({this.name, this.cardId}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('LoyaltyCard', 'name');
    }
    if (cardId == null) {
      throw new BuiltValueNullFieldError('LoyaltyCard', 'cardId');
    }
  }

  @override
  LoyaltyCard rebuild(void updates(LoyaltyCardBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  LoyaltyCardBuilder toBuilder() => new LoyaltyCardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoyaltyCard && name == other.name && cardId == other.cardId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), cardId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoyaltyCard')
          ..add('name', name)
          ..add('cardId', cardId))
        .toString();
  }
}

class LoyaltyCardBuilder implements Builder<LoyaltyCard, LoyaltyCardBuilder> {
  _$LoyaltyCard _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _cardId;
  String get cardId => _$this._cardId;
  set cardId(String cardId) => _$this._cardId = cardId;

  LoyaltyCardBuilder();

  LoyaltyCardBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _cardId = _$v.cardId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoyaltyCard other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoyaltyCard;
  }

  @override
  void update(void updates(LoyaltyCardBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$LoyaltyCard build() {
    final _$result = _$v ?? new _$LoyaltyCard._(name: name, cardId: cardId);
    replace(_$result);
    return _$result;
  }
}
