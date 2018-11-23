import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  static const serializationType = const FullType(User);

  String get nickname;
  String get userId;
  @nullable
  String get status;
  @nullable
  String get username;
  @nullable
  String get password;

  User._();

  factory User([updates(UserBuilder b)]) = _$User;
}
