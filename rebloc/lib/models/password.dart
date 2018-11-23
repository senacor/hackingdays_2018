import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'password.g.dart';

abstract class Password implements Built<Password, PasswordBuilder> {
  static Serializer<Password> get serializer => _$passwordSerializer;

  static const serializationType = const FullType(Password);

  String get password;

  Password._();

  factory Password([updates(PasswordBuilder b)]) = _$Password;
}
