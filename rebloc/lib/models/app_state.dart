import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hello_world/models/loyaltyCard.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  BuiltMap<String, LoyaltyCard> get loyaltyCards;

  AppState._();

  factory AppState.initialState() {
    return AppState();
  }

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;
}