import 'dart:async';

import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;
  final Color _backgroundColor;
  final EdgeInsets _padding;
  final ShapeBorder _shapeBorder;
  final List<BoxShadow> _boxShadow;
  final TextStyle _textStyle;
  final Widget _image;
  final double _imagePadding;
  final bool _enabled;
  final bool _isExpanded;

  static const TextStyle _defaultTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static final ShapeBorder _defaultShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );

  final _onButtonPressedStreamController = StreamController<bool>();

  CommonButton({
    Key key,
    @required VoidCallback onPressed,
    @required String text,
    Color backgroundColor = const Color(0xff2962ff),
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 17.0),
    ShapeBorder shapeBorder,
    List<BoxShadow> boxShadow,
    TextStyle textStyle,
    Widget image,
    double imagePadding,
    bool enabled = true,
    Color disabledBackgroundColor = const Color(0xfffafafa),
    TextStyle disabledTextStyle = const TextStyle(color: Color(0xff7d7d7d)),
    bool isExpanded = true,
  })  : _onPressed = onPressed,
        _text = text,
        _backgroundColor = enabled ? backgroundColor : disabledBackgroundColor,
        _padding = padding,
        _shapeBorder = shapeBorder ?? _defaultShapeBorder,
        _boxShadow = boxShadow ??
            [
              BoxShadow(
                color: Color(0x19000000),
                offset: Offset(0.0, 10.0),
                blurRadius: 25.0,
              ),
            ],
        _textStyle = _defaultTextStyle
            .merge(textStyle)
            .merge(enabled ? null : disabledTextStyle),
        _image = image,
        _imagePadding = imagePadding ?? 8.0,
        _enabled = enabled,
        _isExpanded = isExpanded,
        super(key: key);

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !_enabled,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: _shapeBorder,
            shadows: _boxShadow,
          ),
          child: StreamBuilder<bool>(
            initialData: false,
            stream: _onButtonPressedStreamController.stream,
            builder: (context, snapshot) => Material(
              color: _backgroundColor.withOpacity(snapshot.data ? 0.8 : 1.0),
              shape: _shapeBorder,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapCancel: () => _onButtonPressedStreamController.add(false),
                onTapUp: (_) {
                  _onButtonPressedStreamController.add(false);
                  _onPressed();
                },
                onTapDown: (_) => _onButtonPressedStreamController.add(true),
                child: Padding(
                  padding: _padding,
                  child: Opacity(
                    opacity: snapshot.data ? 0.5 : 1.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize:
                          _isExpanded ? MainAxisSize.max : MainAxisSize.min,
                      children: <Widget>[
                        if (_image != null) ...[
                          _image,
                          SizedBox(width: _imagePadding),
                        ],
                        Text(
                          _text,
                          style: _textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
