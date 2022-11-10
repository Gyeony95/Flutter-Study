import 'package:flutter/material.dart';

class StackableListItem extends StatefulWidget {
  final int index;
  final bool atFirst, lastOne;
  final double opacity;
  final double offset;
  final double widthFactor, heightFactor;
  final Widget child;
  final Axis scrollDirection;

  const StackableListItem({
    Key? key,
    required this.atFirst,
    required this.lastOne,
    required this.index,
    required this.offset,
    required this.opacity,
    required this.widthFactor,
    required this.heightFactor,
    required this.child,
    required this.scrollDirection,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StackableListItem();
}

class _StackableListItem extends State<StackableListItem> {

  @override
  Widget build(BuildContext context) {
    Matrix4 transform;
    Alignment alignment;
    if (widget.scrollDirection == Axis.vertical) {
      alignment = Alignment.topCenter;
      transform = Matrix4.identity()..translate(0, widget.offset);
    } else {
      alignment = Alignment.centerLeft;
      transform = Matrix4.identity()..translate(widget.offset, 0);
    }
    Widget child = Transform(
      alignment: alignment,
      transform: transform,
      child: Opacity(
        opacity: widget.opacity,
        child: Align(
          alignment: alignment,
          widthFactor: widget.lastOne ? 1.0 : widget.widthFactor,
          heightFactor: widget.lastOne ? 1.0 : widget.heightFactor,
          child: widget.child,
        ),
      ),
    );
    return child;
  }

}
