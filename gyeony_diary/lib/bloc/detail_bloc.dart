
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/model/detail_model.dart';
import 'package:gyeony_diary/repo/detail_repo.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(DetailRepo detailRepo) : super(DetailLoading());
  DetailRepo detailRepo;

  @override
  Stream<DetailState> mapEventToState(event) async*{
    if(event is testtest){
      yield* _maptesttestToState(event);
    }
  }
  Stream<DetailState> _maptesttestToState(DetailEvent event) async*{
    yield DetailLoading();
    //여기서 데이터 얻어옴
    List<ImageModel> imageData = [
      ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
      ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
    ];
    yield DetailLoaded(list: imageData);
  }

}