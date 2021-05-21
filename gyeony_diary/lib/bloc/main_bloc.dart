import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/main_state.dart';
import 'package:gyeony_diary/model/chart_model.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainRepo mainRepo) : super(MainLoading());
  MainRepo mainRepo;

  @override
  Stream<MainState> mapEventToState(event) async*{
    if(event is GetDailyDiaryData){
      yield* _mapGetDailyDiaryDataToState(event);
    }


  }

  Stream<MainState> _mapGetDailyDiaryDataToState(MainEvent event) async*{
    yield MainLoading();
    //여기서 데이터 얻어옴
    List<RadialData> radialData = [
      RadialData('1번', 35),
      RadialData('2번', 85),
      RadialData('3번', 44),
    ];
    yield MainLoaded(list: radialData);
  }



}