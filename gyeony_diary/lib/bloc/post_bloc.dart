import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/main_state.dart';
import 'package:gyeony_diary/bloc/post_event.dart';
import 'package:gyeony_diary/bloc/post_state.dart';
import 'package:gyeony_diary/model/post_model.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'package:gyeony_diary/repo/post_repo.dart';
import 'main_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(PostRepo postRepo) : super(PostLoading());
  PostRepo postRepo;

  @override
  Stream<PostState> mapEventToState(event) async*{
    if(event is GetDiaryList){
      yield* _mapGetDiaryListToState(event);
    }
    if(event is SwitchItemState){
      yield* _mapSwitchItemStateToState(event);

    }
  }

  Stream<PostState> _mapGetDiaryListToState(PostEvent event) async*{
    yield PostLoading();
    //여기서 데이터 얻어옴
    List<PostModel> list = [
      PostModel(time : '4월12일', content : '이것은 첫반째 사진으로 먼가 바다의 집,,?',imageUrl : 'assets/images/default_image.jpeg', isOpened: false),
      PostModel(time : '4월12일', content : '두번쨰사진은 움 머냐 이',imageUrl : 'assets/images/default_image2.jpeg', isOpened: false),
      PostModel(time : '4월12일', content : '거이야 이건 일기장 앱이라',imageUrl : 'assets/images/default_image3.jpeg', isOpened: false),
      PostModel(time : '4월12일', content : '이것은 첫반째 사진으로 먼가 바다의 집,,?',imageUrl : 'assets/images/default_image.jpeg', isOpened: false),
      PostModel(time : '4월12일', content : '두번쨰사진은 움 머냐 이',imageUrl : 'assets/images/default_image2.jpeg', isOpened: false),
      PostModel(time : '4월12일', content : '거이야 이건 일기장 앱이라',imageUrl : 'assets/images/default_image3.jpeg', isOpened: false),
    ];
    yield PostLoaded(list: list);
  }

  Stream<PostState> _mapSwitchItemStateToState(PostEvent event) async*{
    var currentState = state as PostLoaded;
    var currentEvent = event as SwitchItemState;
    yield PostLoading();

    currentState.copyWith(
        list: currentState.list.asMap().entries.map((entry) {

          int idx = entry.key;
          PostModel val = entry.value;
          debugPrint('ghghgh  val1 '+val.toString());
          // idx == currentEvent.index ? val.copyWith(isOpened: currentState.list[currentEvent.index].isOpened ? false : true) :  val;
          debugPrint('ghghgh  val2 '+val.toString());
          val.copyWith(isOpened: true);
          return val;
        }).toList()
    );

    // currentState.list.asMap().entries.map((entry) {
    //   int idx = entry.key;
    //   PostModel val = entry.value;
    //
    //   idx == currentEvent.index ? val.copyWith(isOpened: currentState.list[currentEvent.index].isOpened ? false : true) :  val;
    //   return val;
    // });

    debugPrint('ghghgh'+currentState.list[currentEvent.index].isOpened.toString());
    // currentState.list[currentEvent.index].copyWith(isOpened: currentState.list[currentEvent.index].isOpened ? false : true);
    //var newList = currentState.list[currentEvent.index].copyWith(isOpened: true);
    // var count = 0;
    // currentState.copyWith(
    //   list: currentState.list.map((e){
    //     if(count == currentEvent.index){
    //       return e.copyWith(isOpened: true);
    //     }
    //     return e;
    //   })
    // );


    debugPrint('ghghgh'+currentState.list[currentEvent.index].isOpened.toString());
    debugPrint('ghghgh 77 '+ (currentState.list[currentEvent.index].isOpened ? false : true).toString());

    yield PostLoaded(list: currentState.list);
  }
}