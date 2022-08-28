import 'package:flutter/material.dart';
import 'package:flutter_report/main.dart';

class MainFrame extends StatelessWidget {
  final FeatureEnum route;
  final Widget child;
  const MainFrame({required this.route, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(route.name),),
      body: child,
    );
  }
}
