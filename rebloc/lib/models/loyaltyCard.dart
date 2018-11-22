import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'loyaltyCard.g.dart';

abstract class LoyaltyCard implements Built<LoyaltyCard, LoyaltyCardBuilder> {
  static Serializer<LoyaltyCard> get serializer => _$loyaltyCardSerializer;

  static const listSerializationType = const FullType(BuiltList, [FullType(LoyaltyCard)]);

  String get name;
  String get cardId;

  LoyaltyCard._();

  factory LoyaltyCard([updates(LoyaltyCardBuilder b)]) = _$LoyaltyCard;
}