import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'achievement.g.dart';

abstract class Achievement implements Built<Achievement, AchievementBuilder> {
  static Serializer<Achievement> get serializer => _$achievementSerializer;

  static const listSerializationType = const FullType(BuiltList, [FullType(Achievement)]);
  static const serializationType = const FullType(Achievement);

  String get id;
  String get achievementTypeId;
  bool get gained;
  String get title;
  //int get gainedCount;
  String get header;
  String get description;
  String get imageUrl;
  String get previewImageUrl;

  Achievement._();

  factory Achievement([updates(AchievementBuilder b)]) = _$Achievement;
}