import 'package:better_yunar/models/achievement.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/models/onboardingScreen.dart';
import 'package:better_yunar/models/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  BuiltMap<String, LoyaltyCard> get loyaltyCards;
  BuiltMap<String, Achievement> get achievements;
  @nullable
  User get user;
  OnboardingScreen get onboardingScreen;

  AppState._();

  factory AppState.initialState() {
    return AppState();
  }

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;
}
