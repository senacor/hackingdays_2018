import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  static const listSerializationType = const FullType(BuiltList, [FullType(User)]);
  static const serializationType = const FullType(User);

  String get userId;
  String get username;
  String get password;
  String get nickname;

  User._();

  factory User.initialState() {
    return User();
  }

  factory User([updates(UserBuilder b)]) = _$User;
}