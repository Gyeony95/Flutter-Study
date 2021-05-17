import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/main_state.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainRepo mainRepo) : super(MainLoading());
  MainRepo mainRepo;

  @override
  Stream<MainState> mapEventToState(event) {


  }


}