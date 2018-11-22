import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hello_world/models/app_state.dart';
import 'package:rebloc/rebloc.dart';

typedef void NewRouteCallback(Route<dynamic> route, Route<dynamic> previousRoute);

class StartObservingNavigationAction extends Action {}

class StopObservingNavigationAction extends Action {}

class DidPushNamedRouteAction extends Action {
  final String routeName;

  DidPushNamedRouteAction(this.routeName);
}

class PushNamedRouteAction extends Action {
  final String routeName;

  PushNamedRouteAction(this.routeName);
}

class PushNamedReplacementRouteAction extends Action {
  final String routeName;

  PushNamedReplacementRouteAction(this.routeName);
}

class PopRouteAction extends Action {}

class PopAndPushNamedRouteAction extends Action {
  final String routeName;

  PopAndPushNamedRouteAction(this.routeName);
}

class _NavigationBlocObserver extends NavigatorObserver {
  final NewRouteCallback onActiveRouteChanged;

  _NavigationBlocObserver({this.onActiveRouteChanged});

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onActiveRouteChanged != null) {
      onActiveRouteChanged(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    if (onActiveRouteChanged != null) {
      onActiveRouteChanged(newRoute, oldRoute);
    }
  }
}

class NavigationBloc extends SimpleBloc<AppState> {
  NavigationBloc(this.navigatorKey) {
    observer = _NavigationBlocObserver(onActiveRouteChanged: onDidPush);
  }

  final GlobalKey<NavigatorState> navigatorKey;

  _NavigationBlocObserver observer;

  DispatchFunction _dispatcher;

  void onDidPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (_dispatcher != null && route?.settings?.name != null) {
      _dispatcher(DidPushNamedRouteAction(route.settings.name));
    }
  }

  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
    if (action is StartObservingNavigationAction) {
      _dispatcher = dispatcher;
    } else if (action is StopObservingNavigationAction) {
      _dispatcher = null;
    } else {
      final navigatorState = navigatorKey.currentState;
      if (navigatorState != null && navigatorState is NavigatorState) {
        if (action is PopRouteAction) {
          navigatorState.pop();
        } else if (action is PushNamedRouteAction) {
          navigatorState.pushNamed(action.routeName);
        } else if (action is PushNamedReplacementRouteAction) {
          navigatorState.pushReplacementNamed(action.routeName);
        } else if (action is PopAndPushNamedRouteAction) {
          navigatorState.popAndPushNamed(action.routeName);
        }
      }
    }

    return action;
  }
}