import 'package:flutter/material.dart';
import 'package:hello_world/screens/addCardScreen.dart';
import 'package:hello_world/bloc/loayaltyCard_bloc.dart';
import 'package:hello_world/models/app_state.dart';
import 'package:rebloc/rebloc.dart';
import 'package:hello_world/bloc/navigation_bloc.dart';
import 'package:hello_world/screens/splash_screen.dart';

import 'screens/mainScreen.dart';

void main() => runApp(BetterYunarApp());

class BetterYunarApp extends StatelessWidget {
  Store<AppState> store;
  NavigationBloc navBloc;
  final navigatorKey = GlobalKey<NavigatorState>();

  BetterYunarApp() {
    navBloc = NavigationBloc(navigatorKey);

    store = Store<AppState>(
      initialState: AppState.initialState(),
      blocs: [
        LoyaltyCardBloc(),
        navBloc,
      ],
    );

    store.dispatcher(StartObservingNavigationAction());
    store.dispatcher(RefreshLoyaltyCardsAction());
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');

    if (path[1] == 'mainScreen') {
      return new MaterialPageRoute<int>(
        builder: (context) => MainScreen(),
        settings: settings,
      );
    }

    if (path[1] == 'addLoyaltyCard') {
      return new MaterialPageRoute<int>(
        builder: (context) => AddCardScreen(),
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
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: _onGenerateRoute,
        navigatorObservers: [navBloc.observer],
      ),
    );
  }
}
