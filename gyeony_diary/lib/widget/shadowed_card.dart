import 'package:flutter/material.dart';

class ShadowedCard extends StatelessWidget {
  final bool enabled;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadowList;
  final List<BoxShadow> disabledShadowList;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Widget child;
  final VoidCallback onPressed;

  ShadowedCard({
    this.enabled = true,
    this.margin,
    BorderRadius borderRadius,
    List<BoxShadow> shadowList,
    this.disabledShadowList,
    this.backgroundColor = Colors.white,
    this.disabledBackgroundColor = const Color(0xfffdfdfd),
    @required this.child,
    this.onPressed,
  })  : borderRadius = borderRadius ?? BorderRadius.circular(20.0),
        shadowList = shadowList ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: Offset(0.0, 10.0),
                blurRadius: 25.0,
              )
            ];

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          shadows: enabled ? shadowList : disabledShadowList,
        ),
        child: Material(
          color: enabled ? backgroundColor : disabledBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: InkWell(
            customBorder: RoundedRectangleBorder(borderRadius: borderRadius),
            onTap: onPressed,
            child: child,
          ),
        ),
      );
}
