import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
enum MainTab{first, second, third}

class MainTabState extends Equatable{
  final MainTab tab;
  final dynamic arguments;


  const MainTabState({
    @required this.tab,
    this.arguments,
  }): assert(tab != null);

  @override
  List<Object> get props => [tab, arguments];

  @override
  String toString() => '''$MainTabState {
    tab: $tab,
    arguments: $arguments,
  }''';
}