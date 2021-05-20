import 'package:flutter/material.dart';

class CustomClampingScrollPhysics extends ClampingScrollPhysics {
  final bool canUnderscroll;
  final bool canOverscroll;

  const CustomClampingScrollPhysics({
    ScrollPhysics parent,
    this.canUnderscroll = false,
    this.canOverscroll = false,
  }) : super(parent: parent);

  @override
  CustomClampingScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomClampingScrollPhysics(
        parent: buildParent(ancestor),
        canUnderscroll: canUnderscroll,
        canOverscroll: canOverscroll);
  }

  /// Removes the overscroll and underscroll conditions from the original
  /// [ClampingScrollPhysics.applyBoundaryConditions].
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return canUnderscroll ? 0.0 : value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return canOverscroll ? 0.0 : value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }
}
