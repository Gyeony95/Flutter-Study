import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_toy/maintab/main_tab_event.dart';
import 'package:gh_toy/maintab/main_tab_state.dart';

class MainTabBloc extends Bloc<MainTabEvent, MainTabState>{
  MainTabBloc() : super(MainTabState(tab: MainTab.first));

  @override
  Stream<MainTabState> mapEventToState(MainTabEvent event) async*{
    if (event is ChangeMainTab) {
      yield MainTabState(
          tab: event.tab,
          arguments: event.arguments,
      );
    }


  }


}