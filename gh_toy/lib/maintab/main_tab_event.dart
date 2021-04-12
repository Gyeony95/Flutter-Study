import 'package:equatable/equatable.dart';
import 'package:gh_toy/maintab/main_tab_state.dart';

abstract class MainTabEvent extends Equatable{
  const MainTabEvent();
}

class ChangeMainTab extends MainTabEvent {
  final MainTab tab;
  final dynamic arguments;

  const ChangeMainTab({
    this.tab,
    this.arguments,
  }) : assert(tab != null);

  @override
  List<Object> get props => [tab, arguments];

  @override
  String toString() => '''$ChangeMainTab {
    tab: $tab,
    arguments: $arguments,
  }''';
}
