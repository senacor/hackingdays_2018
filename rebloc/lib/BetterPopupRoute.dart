import 'package:flutter/material.dart';

class BetterPopupRoute<T> extends PopupRoute<T> {

  BetterPopupRoute({
    @required this.builder,
    RouteSettings settings,
  }) : assert(builder != null),
        super(settings: settings);

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  Color get barrierColor => Color.fromARGB(200, 156, 160, 164);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => new Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

}
