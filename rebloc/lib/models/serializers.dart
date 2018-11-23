library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/models/achievement.dart';
import 'package:better_yunar/models/onboardingResponse.dart';
import 'package:better_yunar/models/onboardingScreen.dart';
import 'package:better_yunar/models/user.dart';
import 'package:better_yunar/models/password.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  User,
  AppState,
  LoyaltyCard,
  Achievement,
  OnboardingResponse,
  OnboardingScreen,
  Password
])
// built_value doesn't include serializers for lists of values by default, so
// any lists that we need to directly fetch from the API or store locally need
// to be added manually here.
final Serializers serializers = (_$serializers.toBuilder()
    ..addBuilderFactory(LoyaltyCard.listSerializationType, () => new ListBuilder<LoyaltyCard>())
    ..addBuilderFactory(Achievement.listSerializationType, () => new ListBuilder<Achievement>())
    ..addPlugin(StandardJsonPlugin())
  ).build();