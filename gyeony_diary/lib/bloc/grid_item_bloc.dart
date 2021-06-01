
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/grid_item_event.dart';
import 'package:gyeony_diary/bloc/grid_item_state.dart';
import 'package:gyeony_diary/model/detail_model.dart';
import 'package:gyeony_diary/repo/detail_repo.dart';
import 'package:gyeony_diary/repo/grid_item_repo.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class GridItemBloc extends Bloc<GridItemEvent, GridItemState> {
  GridItemBloc(GridItemRepo gridItemRepo) : super(GridItemLoading());
  GridItemRepo gridItemRepo;

  @override
  Stream<GridItemState> mapEventToState(event) async*{
    // if(event is GetImageList){
    //   yield* _mapGetImageListToState(event);
    // }
  }
  // Stream<DetailState> _mapGetImageListToState(DetailEvent event) async*{
  //   yield DetailLoading();
  //   //여기서 데이터 얻어옴
  //   List<ImageModel> imageData = [
  //     ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image3.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image.jpeg'),
  //     ImageModel(imageUrl: 'assets/images/default_image2.jpeg'),
  //   ];
  //   yield DetailLoaded(list: imageData);
  // }

}