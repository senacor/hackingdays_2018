import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'onboardingScreen.g.dart';

abstract class OnboardingScreen implements Built<OnboardingScreen, OnboardingScreenBuilder> {
  static Serializer<OnboardingScreen> get serializer => _$onboardingScreenSerializer;

  static const listSerializationType = const FullType(BuiltList, [FullType(OnboardingScreen)]);
  static const serializationType = const FullType(OnboardingScreen);

  bool get isOnboardingRequestRunning;
  @nullable
  String get onboardingRequestErrorMessage;

  OnboardingScreen._();

  factory OnboardingScreen.initialState() {
    return OnboardingScreen(

    );
  }

  factory OnboardingScreen([updates(OnboardingScreenBuilder b)]) = _$OnboardingScreen;
}

abstract class OnboardingScreenBuilder implements Builder<OnboardingScreen, OnboardingScreenBuilder> {
  bool isOnboardingRequestRunning = false;

  String onboardingRequestErrorMessage;

  factory OnboardingScreenBuilder() = _$OnboardingScreenBuilder;
  OnboardingScreenBuilder._();
}

