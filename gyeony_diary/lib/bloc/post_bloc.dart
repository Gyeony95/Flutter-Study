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
  }

  Stream<PostState> _mapGetDiaryListToState(PostEvent event) async*{
    yield PostLoading();
    //여기서 데이터 얻어옴
    List<PostModel> list = [
      PostModel(time : '4월12일', content : '이것은 첫반째 사진으로 먼가 바다의 집,,?',imageUrl : 'assets/images/default_image.jpeg'),
      PostModel(time : '4월12일', content : '두번쨰사진은 움 머냐 이',imageUrl : 'assets/images/default_image2.jpeg'),
      PostModel(time : '4월12일', content : '거이야 이건 일기장 앱이라',imageUrl : 'assets/images/default_image3.jpeg'),
      PostModel(time : '4월12일', content : '이것은 첫반째 사진으로 먼가 바다의 집,,?',imageUrl : 'assets/images/default_image.jpeg'),
      PostModel(time : '4월12일', content : '두번쨰사진은 움 머냐 이',imageUrl : 'assets/images/default_image2.jpeg'),
      PostModel(time : '4월12일', content : '거이야 이건 일기장 앱이라',imageUrl : 'assets/images/default_image3.jpeg'),
    ];
    yield PostLoaded(list: list);
  }
}