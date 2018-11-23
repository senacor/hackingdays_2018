import 'package:better_yunar/bloc/blocs.dart';
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart';
import 'package:better_yunar/bloc/navigation_bloc.dart';
import 'package:better_yunar/data/firebase_holder.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/screens/achievementBoard.dart';
import 'package:better_yunar/screens/addCardScreen.dart';
import 'package:better_yunar/screens/onboarding_screen.dart';
import 'package:better_yunar/screens/splash_screen.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';

import 'BetterPopupRoute.dart';
import 'screens/achievementDetails.dart';
import 'screens/mainScreen.dart';

void main() => runApp(BetterYunarApp());

class BetterYunarApp extends StatelessWidget {
  Store<AppState> store;
  NavigationBloc navBloc;
  final navigatorKey = GlobalKey<NavigatorState>();

  BetterYunarApp() {
    navBloc = NavigationBloc(navigatorKey);

    var blocs = new List<Bloc<AppState>>();
    createBlocs().forEach((element) => blocs.add(element));
    blocs.add(navBloc);

    store = Store<AppState>(
      initialState: AppState.initialState(),
      blocs: blocs,
    );

    FirebaseHolder.instance().setDispatcher(store.dispatcher);
    store.dispatcher(StartObservingNavigationAction());
    store.dispatcher(RefreshLoyaltyCardsAction());
  }

  Route _onGenerateRoute(RouteSettings settings) {
    log.info("_onGenerateRoute: $settings");

    var path = settings.name.split('/');

    if (path[1] == 'mainScreen') {
      return new MaterialPageRoute<int>(
        builder: (context) => MainScreen(),
        settings: settings,
      );
    }

    if (path[1] == 'achievements') {
      return new BetterPopupRoute<int>(
        builder: (context) => new AchievementDetails(achievementId: path[2]),
        settings: settings,
      );
    }

    if (path[1] == 'achievementBoard') {
      return new MaterialPageRoute(
        builder: (context) => AchievementBoardScreen(),
        settings: settings,
      );
    }

    if (path[1] == 'addLoyaltyCard') {
      return new MaterialPageRoute<int>(
        builder: (context) => AddCardScreen(),
        settings: settings,
      );
    }

    if (path[1] == 'onboarding') {
      return new MaterialPageRoute<int>(
        builder: (context) => OnboardingScreen(),
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (context) => SplashScreen(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Better Yunar',
        theme: ThemeData(
          backgroundColor: Color.fromARGB(255, 99, 205, 218),
          primaryColor: Color.fromARGB(255, 76, 81, 208),
        ),
        onGenerateRoute: _onGenerateRoute,
        navigatorKey: navigatorKey,
        navigatorObservers: [navBloc.observer],
      ),
    );
  }
}
