import 'package:better_yunar/bloc/navigation_bloc.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rebloc/rebloc.dart';

class FirebaseHolder {
    static FirebaseHolder _instance;

    String firebaseToken;
    DispatchFunction _dispatcher;
    final _firebaseMessaging = FirebaseMessaging();

    FirebaseHolder._internal() {
        initFirebaseMessaging();
    }

    void setDispatcher(DispatchFunction dispatcher) {
        _dispatcher = dispatcher;
    }

    void _navigateToItemDetail(Map<String, dynamic> message) {
        final data = message["notification"] ?? message;

        if (data["title"] == "Achievement") {
            log.info("Navigating to Achievementboard");
            _dispatcher(PushNamedRouteAction("/achievementBoard"));
        }
        else {
            log.info("Not navigating to ${data["title"]}");
        }
    }

    void initFirebaseMessaging() {
        _firebaseMessaging.configure(
            onMessage: (Map<String, dynamic> message) async {
                log.info("onMessage: $message");
                _navigateToItemDetail(message);
            },

            onLaunch: (Map<String, dynamic> message) async {
                log.info("onLaunch: $message");
                _navigateToItemDetail(message);
            },

            onResume: (Map<String, dynamic> message) async {
                log.info("onResume: $message");
                _navigateToItemDetail(message);
            },
        );

        _firebaseMessaging.requestNotificationPermissions(
            const IosNotificationSettings(sound: true, badge: true, alert: true)
        );

        _firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
            log.info("Settings registered: $settings");
        });

        _firebaseMessaging
            .getToken()
            .then((String token) {
            assert (token != null);
            log.info("Token received: $token");
            firebaseToken = token;
        });
    }

    Future onSelectNotification(String payload) async {
        log.info("onSelectNotification: $payload");
        if (payload != null) {

        }
    }

    factory FirebaseHolder.instance() {
        if (_instance == null) {
            _instance = FirebaseHolder._internal();
        }
        return _instance;
    }
}
