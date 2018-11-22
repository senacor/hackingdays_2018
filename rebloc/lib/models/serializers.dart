library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/models/onboarding.dart';
import 'package:better_yunar/models/user.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AppState,
  LoyaltyCard
])
// built_value doesn't include serializers for lists of values by default, so
// any lists that we need to directly fetch from the API or store locally need
// to be added manually here.
final Serializers serializers = (_$serializers.toBuilder()
    ..addBuilderFactory(
        LoyaltyCard.listSerializationType, () => new ListBuilder<LoyaltyCard>())
    ..addPlugin(StandardJsonPlugin())
  ).build();