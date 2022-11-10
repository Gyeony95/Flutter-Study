
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_report/feature/08_stackable_list/stackable_list_item.dart';

class StackableList extends StatefulWidget {
  final Axis scrollDirection;
  final IndexedWidgetBuilder builder;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final int itemCount;

  /// [scrollDirection] 이 Axis.vertical 이면 높이
  /// [scrollDirection] 이 Axis.horizontal 이면 너비
  final double itemExtent;

  /// 0.0 ~ 1.0
  final double fadeOutFrom;

  /// 0.0 ~ 1.0
  final double heightFactor;

  /// 0.0 ~ 1.0
  final double widthFactor;

  const StackableList({
    Key? key,
    required this.itemCount,
    required this.builder,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.controller,
    this.physics,
    required this.itemExtent,
    this.fadeOutFrom = 0.7,
    this.heightFactor = 1,
    this.widthFactor = 1,
  })  : super(key: key);

  @override
  State<StatefulWidget> createState() => StackableListState();
}

class StackableListState extends State<StackableList> {
  late final ScrollController controller;

  @override
  void initState() {
    controller = widget.controller ?? ScrollController();
    controller.addListener(_update);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final realExtent = widget.itemExtent *
        (widget.scrollDirection == Axis.horizontal
            ? widget.widthFactor
            : widget.heightFactor);
    return Stack(children: [
      ListView.builder(
          scrollDirection: widget.scrollDirection,
          padding: widget.padding,
          controller: controller,
          itemCount: widget.itemCount,
          physics: widget.physics ?? const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            double scroll =
            ((controller.offset - index * realExtent) / realExtent);
            double currentScroll = scroll.clamp(0.0, 1.0);

            double opacity = 1.0;
            double offset = 0;
            bool atFirst = false;

            if (currentScroll > 0 || (index == 0 && controller.offset <= 0)) {
              if (currentScroll < 1) {
                atFirst = true;
              }
              if (currentScroll >= widget.fadeOutFrom) {
                if (widget.fadeOutFrom == 1) {
                  opacity = 0;
                } else {
                  final fadeOut =
                  ((1 - currentScroll) / (1.0 - widget.fadeOutFrom))
                      .clamp(0.0, 1.0);
                  opacity = lerpDouble(0.0, 1.0, fadeOut)!;
                }
                // if (index == 0) print('$fadeOut');
              }

              /// 计算偏移
              offset = (currentScroll * realExtent).roundToDouble();
            }
            opacity = opacity.clamp(0.0, 1.0);
            return StackableListItem(
              key: UniqueKey(),
              scrollDirection: widget.scrollDirection,
              atFirst: atFirst,
              lastOne: index == (widget.itemCount - 1),
              index: index,
              offset: offset,
              opacity: opacity,
              widthFactor: widget.widthFactor,
              heightFactor: widget.heightFactor,
              child: SizedBox(
                width: widget.scrollDirection == Axis.vertical
                    ? double.infinity
                    : widget.itemExtent,
                height: widget.scrollDirection == Axis.vertical
                    ? widget.itemExtent
                    : double.infinity,
                child: widget.builder(context, index),
              ),
            );
          }),
    ]);
  }
}
