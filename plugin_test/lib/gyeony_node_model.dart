import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GyeonyNodeModel {
  final IconData? iconData;
  final String name;
  final Function? onPressed;

  const GyeonyNodeModel({
    this.iconData,
    required this.name,
    this.onPressed,
  });
}