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

// A NavigatorObserver designed to work with NavigationBloc.
//
// This observer accepts a callback in its constructor, which is invoked anytime
// it receives a `didPush` event from the Navigator it observes.
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

/// A Bloc for observing and manipulating a [Navigator].
///
/// This class is capable of dispatching an [Action] when a [Navigator] widget
/// pushes a new route, which can be useful for example, in automatically
/// kicking off network requests absed on user navigation. It can also pop and
/// push routes based on [Action]s it receives from the dispatch stream.
///
/// To use this class:
///
/// 1. Create a GlobalKey<NavigatorState>.
/// 2. Call the constructor with that [GlobalKey].
/// 3. Create a Navigator using the same GlobalKey, and register the
///   [_NavigationBlocObserver] returned by [observer] as one of the navigator
///   observers for that Navigator.
/// 4. The NavigationBloc is now ready to respond to actions.
/// 5. At some point, dispatch a [StartObservingNavigationAction].
/// 6. The NavigationBloc will begin responding to new routes pushed by the
///   Navigator.
class NavigationBloc extends SimpleBloc<AppState> {
  NavigationBloc(this.navigatorKey) {
    observer = _NavigationBlocObserver(onActiveRouteChanged: onDidPush);
  }

  /// GlobalKey identifying the Navigator this Bloc observes/manages.
  final GlobalKey<NavigatorState> navigatorKey;

  /// NavigatorObserver that should be given the the Navigator observed by this
  /// Bloc.
  _NavigationBlocObserver observer;

  // Dispatcher that can be used to dispatch actions to the Store for which this
  // Bloc acts as middleware.
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