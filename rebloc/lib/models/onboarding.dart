import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'onboarding.g.dart';

abstract class Onboarding implements Built<Onboarding, OnboardingBuilder> {
  static Serializer<Onboarding> get serializer => _$onboardingSerializer;

  static const listSerializationType = const FullType(BuiltList, [FullType(Onboarding)]);
  static const serializationType = const FullType(Onboarding);

  bool get isOnboardingRequestRunning;
  @nullable
  String get onboardingRequestErrorMessage;

  Onboarding._();

  factory Onboarding.initialState() {
    return Onboarding(

    );
  }

  factory Onboarding([updates(OnboardingBuilder b)]) = _$Onboarding;
}

abstract class OnboardingBuilder implements Builder<Onboarding, OnboardingBuilder> {
  bool isOnboardingRequestRunning = false;

  String onboardingRequestErrorMessage;

  factory OnboardingBuilder() = _$OnboardingBuilder;
  OnboardingBuilder._();
}

