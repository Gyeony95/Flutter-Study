import 'package:flutter/material.dart';

enum ScreenTransitionType {
  fade,
  downToUp,
  scale,
  none,
  osDefault,
}

class ScreenRouteTransition<T> extends PageRouteBuilder<T> {
  ScreenRouteTransition({
    @required RouteSettings settings,
    @required Widget child,
    @required ScreenTransitionType type,
    Color barrierColor,
    bool barrierDismissible = false,
    bool opaque = false,
    Duration duration = const Duration(milliseconds: 300),
  })  : assert(type != null),
        super(
        settings: settings,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        opaque: opaque,
        pageBuilder: (_, __, ___) => child,
        transitionDuration: duration,
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) {
          switch (type) {
            case ScreenTransitionType.fade:
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            case ScreenTransitionType.downToUp:
              final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              );

              return SlideTransition(
                transformHitTests: false,
                position: tween.animate(curvedAnimation),
                child: child,
              );
            case ScreenTransitionType.scale:
              return ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    0.50,
                    curve: Curves.easeOut,
                  ),
                ),
                child: child,
              );
            case ScreenTransitionType.none:
              return child;
            case ScreenTransitionType.osDefault:
              final theme = Theme.of(context).pageTransitionsTheme;
              return theme.buildTransitions(
                ModalRoute.of(context),
                context,
                animation,
                secondaryAnimation,
                child,
              );
            default:
              return null;
          }
        },
      );
}
