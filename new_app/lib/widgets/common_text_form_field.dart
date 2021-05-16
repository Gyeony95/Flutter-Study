import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final List<TextInputFormatter> _inputFormatters;
  final bool _autofocus;
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;
  final Function(String) _validator;
  final Function(String) _onSaved;
  final String _labelText;
  final TextStyle _labelStyle;
  final String _hintText;
  final TextStyle _hintStyle;
  final TextInputAction _textInputAction;
  final VoidCallback _onEditingComplete;
  final Function(String) _onFieldSubmitted;
  final bool _obscureText;
  final TextInputType _keyboardType;
  final bool _readOnly;
  final bool _enabled;
  final TextStyle _style;
  final Color _fillColor;
  // final bool _autovalidate; //'This feature was deprecated after v1.19.0.'
  final int _maxLength;
  final EdgeInsets _contentPadding;
  final InputCounterWidgetBuilder _buildCounter;

  final StreamController<bool> _focusStreamController;
  final StreamController<String> _textChangedStreamController;

  final bool isClearButtonEnabled;

  static final _defaultTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  CommonTextFormField({
    Key key,
    List<TextInputFormatter> inputFormatters,
    bool autofocus = false,
    FocusNode focusNode,
    @required TextEditingController controller,
    Function(String) validator,
    String labelText,
    TextStyle labelStyle,
    String hintText,
    TextStyle hintStyle,
    Function(String) onSaved,
    TextInputAction textInputAction,
    VoidCallback onEditingComplete,
    Function(String) onFieldSubmitted,
    bool obscureText = false,
    TextInputType keyboardType,
    bool readOnly = false,
    bool enabled = true,
    TextStyle style,
    Color fillColor,
    // bool autovalidate = false, //'This feature was deprecated after v1.19.0.'
    int maxLength,
    EdgeInsets contentPadding =
    const EdgeInsets.only(bottom: 10.0, right: 30.0),
    InputCounterWidgetBuilder buildCounter,
    this.isClearButtonEnabled = true,
  })  : _inputFormatters = inputFormatters,
        _autofocus = autofocus,
        _focusNode = focusNode,
        _textEditingController = controller,
        _validator = validator,
        _onSaved = onSaved,
        _labelText = labelText,
        _labelStyle = labelStyle,
        _hintText = hintText,
        _hintStyle = hintStyle,
        _textInputAction = textInputAction,
        _onEditingComplete = onEditingComplete,
        _onFieldSubmitted = onFieldSubmitted,
        _obscureText = obscureText,
        _keyboardType = keyboardType,
        _focusStreamController = StreamController<bool>(),
        _textChangedStreamController = StreamController<String>(),
        _readOnly = readOnly,
        _enabled = enabled,
        _style = _defaultTextStyle.merge(style),
        _fillColor = fillColor,
        // _autovalidate = autovalidate, //'This feature was deprecated after v1.19.0.'
        _maxLength = maxLength,
        _contentPadding = contentPadding,
        _buildCounter = buildCounter,
        super(key: key) {
    _focusNode?.addListener(() {
      _focusStreamController.add(_focusNode.hasFocus);
    });
    _textEditingController.addListener(() {
      _textChangedStreamController.add(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
      initialData: false,
      stream: _focusStreamController.stream,
      builder: (context, focusSnapshot) => Stack(
        children: [
          TextFormField(
            inputFormatters: _inputFormatters,
            autofocus: _autofocus,
            // autovalidate: _autovalidate, //'This feature was deprecated after v1.19.0.'
            enabled: _enabled,
            focusNode: _focusNode,
            controller: _textEditingController,
            validator: _validator,
            onSaved: _onSaved,
            onEditingComplete: _onEditingComplete,
            onFieldSubmitted: _onFieldSubmitted,
            cursorColor: Color(0xff2962ff),
            obscureText: _obscureText,
            readOnly: _readOnly,
            style: _enabled
                ? _style
                : _style?.copyWith(
              color: Color(0x66000000),
            ),
            keyboardType: _keyboardType,
            maxLength: _maxLength,
            buildCounter: _buildCounter ??
                    (_, {currentLength, maxLength, isFocused}) => null,
            decoration: InputDecoration(
              filled: _fillColor != null,
              fillColor: _fillColor,
              contentPadding: _contentPadding,
              labelText: _labelText,
              labelStyle: focusSnapshot.data ||
                  _textEditingController.text.isNotEmpty
                  ? _labelStyle
                  : _labelStyle?.copyWith(
                color: Color(0x66000000),
              ),
              hintStyle: _hintStyle,
              hintText: _hintText,
              alignLabelWithHint: true,
              enabled: _enabled,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffcccccc),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff2962ff),
                ),
              ),
            ),
            textInputAction: _textInputAction,
          ),
          Positioned(
            right: 0.0,
            top: 10.0,
            child: StreamBuilder<String>(
              stream: _textChangedStreamController.stream,
              builder: (context, textSnapshot) => Visibility(
                visible: isClearButtonEnabled &&
                    textSnapshot.data?.isNotEmpty == true &&
                    focusSnapshot.data,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _textEditingController.clear(),
                  child: Container(
                    padding: const EdgeInsets.all(11.0),
                    child: Image.asset(
                      'assets/images/ic_clear.png',
                      width: 14.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
}

class CommonFormatterTextFormField extends StatelessWidget {
  final bool _autofocus;
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;
  final Function(String) _validator;
  final Function(String) _onSaved;
  final List<TextInputFormatter> _inputFormatters;
  final String _labelText;
  final TextStyle _labelStyle;
  final String _hintText;
  final TextStyle _hintStyle;
  final TextInputAction _textInputAction;
  final VoidCallback _onEditingComplete;
  final Function(String) _onFieldSubmitted;
  final bool _obscureText;
  final TextInputType _keyboardType;
  final bool _readOnly;
  final bool _enabled;
  final TextStyle _style;
  final Color _fillColor;
  // final bool _autovalidate; //'This feature was deprecated after v1.19.0.'
  final int _maxLength;
  final EdgeInsets _contentPadding;
  final InputCounterWidgetBuilder _buildCounter;

  final StreamController<bool> _focusStreamController;
  final StreamController<String> _textChangedStreamController;

  final VoidCallback _onClear;
  final bool isClearButtonEnabled;

  static final _defaultTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  CommonFormatterTextFormField({
    Key key,
    bool autofocus = false,
    FocusNode focusNode,
    @required TextEditingController controller,
    Function(String) validator,
    String labelText,
    TextStyle labelStyle,
    String hintText,
    TextStyle hintStyle,
    Function(String) onSaved,
    List<TextInputFormatter> inputFormatters,
    TextInputAction textInputAction,
    VoidCallback onEditingComplete,
    Function(String) onFieldSubmitted,
    bool obscureText = false,
    TextInputType keyboardType,
    bool readOnly = false,
    bool enabled = true,
    TextStyle style,
    Color fillColor,
    // bool autovalidate = false, //'This feature was deprecated after v1.19.0.'
    int maxLength,
    EdgeInsets contentPadding = const EdgeInsets.only(bottom: 10.0, right: 30.0),
    InputCounterWidgetBuilder buildCounter,
    VoidCallback onClear,
    this.isClearButtonEnabled = true,
  })  : _autofocus = autofocus,
        _focusNode = focusNode,
        _textEditingController = controller,
        _validator = validator,
        _onSaved = onSaved,
        _inputFormatters = inputFormatters,
        _labelText = labelText,
        _labelStyle = labelStyle,
        _hintText = hintText,
        _hintStyle = hintStyle,
        _textInputAction = textInputAction,
        _onEditingComplete = onEditingComplete,
        _onFieldSubmitted = onFieldSubmitted,
        _obscureText = obscureText,
        _keyboardType = keyboardType,
        _focusStreamController = StreamController<bool>(),
        _textChangedStreamController = StreamController<String>(),
        _readOnly = readOnly,
        _enabled = enabled,
        _style = _defaultTextStyle.merge(style),
        _fillColor = fillColor,
  // _autovalidate = autovalidate, //'This feature was deprecated after v1.19.0.'
        _maxLength = maxLength,
        _contentPadding = contentPadding,
        _buildCounter = buildCounter,
        _onClear = onClear,
        super(key: key) {
    _focusNode?.addListener(() {
      _focusStreamController.add(_focusNode.hasFocus);
    });
    _textEditingController.addListener(() {
      _textChangedStreamController.add(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
      initialData: false,
      stream: _focusStreamController.stream,
      builder: (context, focusSnapshot) => Stack(
        children: [
          TextFormField(
            autofocus: _autofocus,
            // autovalidate: _autovalidate, //'This feature was deprecated after v1.19.0.'
            enabled: _enabled,
            focusNode: _focusNode,
            controller: _textEditingController,
            validator: _validator,
            onSaved: _onSaved,
            inputFormatters: _inputFormatters,
            onEditingComplete: _onEditingComplete,
            onFieldSubmitted: _onFieldSubmitted,
            cursorColor: Color(0xff2962ff),
            obscureText: _obscureText,
            readOnly: _readOnly,
            style: _enabled
                ? _style
                : _style?.copyWith(
              color: Color(0x66000000),
            ),
            keyboardType: _keyboardType,
            maxLength: _maxLength,
            buildCounter: _buildCounter ??
                    (_, {currentLength, maxLength, isFocused}) => null,
            decoration: InputDecoration(
              filled: _fillColor != null,
              fillColor: _fillColor,
              contentPadding: _contentPadding,
              labelText: _labelText,
              labelStyle: focusSnapshot.data ||
                  _textEditingController.text.isNotEmpty
                  ? _labelStyle
                  : _labelStyle?.copyWith(
                color: Color(0x66000000),
              ),
              hintStyle: _hintStyle,
              hintText: _hintText,
              alignLabelWithHint: true,
              enabled: _enabled,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffcccccc),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff2962ff),
                ),
              ),
            ),
            textInputAction: _textInputAction,
          ),
          Positioned(
            right: 0.0,
            top: 10.0,
            child: StreamBuilder<String>(
              stream: _textChangedStreamController.stream,
              builder: (context, textSnapshot) => Visibility(
                visible: isClearButtonEnabled &&
                    textSnapshot.data?.isNotEmpty == true &&
                    focusSnapshot.data,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _textEditingController.clear();
                    _onClear();
                    },
                  child: Container(
                    padding: const EdgeInsets.all(11.0),
                    child: Image.asset(
                      'assets/images/ic_clear.png',
                      width: 14.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
}

