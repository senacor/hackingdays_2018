import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'onboardingResponse.g.dart';

abstract class OnboardingResponse implements Built<OnboardingResponse, OnboardingResponseBuilder> {
  static Serializer<OnboardingResponse> get serializer => _$onboardingResponseSerializer;

  static const serializationType = const FullType(OnboardingResponse);
  
  OnboardedUser get onboardedUser;
  Auth get auth;

  OnboardingResponse._();

  factory OnboardingResponse.initialState() {
    return OnboardingResponse();
  }

  factory OnboardingResponse([updates(OnboardingResponseBuilder b)]) = _$OnboardingResponse;
}

abstract class OnboardedUser implements Built<OnboardedUser, OnboardedUserBuilder> {
  static Serializer<OnboardedUser> get serializer => _$onboardedUserSerializer;

  static const serializationType = const FullType(OnboardedUser);

  String get userId;
  String get nickname;
  String get status;

  OnboardedUser._();

  factory OnboardedUser.initialState() {
    return OnboardedUser();
  }

  factory OnboardedUser([updates(OnboardedUserBuilder b)]) = _$OnboardedUser;
}

abstract class Auth implements Built<Auth, AuthBuilder> {
  static Serializer<Auth> get serializer => _$authSerializer;

  static const serializationType = const FullType(Auth);

  String get username;
  String get password;
  String get clientId;

  Auth._();

  factory Auth.initialState() {
    return Auth();
  }

  factory Auth([updates(AuthBuilder b)]) = _$Auth;
}