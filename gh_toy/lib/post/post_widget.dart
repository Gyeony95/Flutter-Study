import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainTabBadgeWrapper extends StatelessWidget {
  final badgeCount;
  final Widget child;
  final Color backgroundColor;
  final TextStyle badgeStyle;

  const MainTabBadgeWrapper({
    Key key,
    this.badgeCount = 0,
    this.child,
    this.backgroundColor = const Color(0xfff95e28),
    this.badgeStyle = const TextStyle(
      fontSize: 12.0,
      color: Colors.white,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    child: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Center(child: child),
        if (badgeCount > 0)
          Container(
            alignment: Alignment(1, -1),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0),
              child: SvgPicture.asset(
                'assets/images/ic_dot_one.svg',
                width: 6.0,
                color: Colors.red,
              ),
            ),
          ),
      ],
    ),
  );
}
