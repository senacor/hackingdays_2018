import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/models/user.dart';
import 'package:better_yunar/models/onboarding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _firebaseToken;
  BuiltMap<String, LoyaltyCard> get loyaltyCards;
  @nullable
  User get user;
  Onboarding get onboarding;

  AppState._();

  factory AppState.initialState() {
    final AppState result = AppState();
    final FirebaseMessaging _firebaseMessaging = result._firebaseMessaging;

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
//        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
//        _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
          assert (token != null);
          print("Token received: $token");
          result._firebaseToken = token;
        }
    );

    return result;
  }

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;
}
