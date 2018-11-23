import 'package:flutter/material.dart';
import 'package:better_yunar/screens/addCardScreen.dart';
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/bloc/navigation_bloc.dart';
import 'package:better_yunar/screens/splash_screen.dart';
import 'package:better_yunar/screens/onboarding_screen.dart';
import 'package:better_yunar/bloc/blocs.dart';

import 'screens/mainScreen.dart';

void main() => runApp(BetterYunarApp());

class BetterYunarApp extends StatelessWidget {
  final Store<AppState> store;
  final NavigationBloc navBloc;
  static final navigatorKey = GlobalKey<NavigatorState>();

  BetterYunarApp()
      : navBloc = NavigationBloc(navigatorKey),
        store = Store<AppState>(
          initialState: AppState.initialState(),
          blocs: blocs,
        ) {

    var blocs = List<Bloc<AppState>>();
    createBlocs().forEach((element) => blocs.add(element));
    blocs.add(navBloc);

    store.dispatcher(StartObservingNavigationAction());
    store.dispatcher(RefreshLoyaltyCardsAction());
  }

  Widget _route(String path) {
    print(path);
    switch (path) {
      case 'mainScreen':
        return MainScreen();
      case 'addLoyaltyCard':
        return AddCardScreen();
      case 'onBoarding':
        return OnboardingScreen();
      case 'addCardScreen':
        return AddCardScreen();
      default:
        return SplashScreen();
    }
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<int>(
      builder: (_) => _route(settings.name.split('/')[1]),
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
