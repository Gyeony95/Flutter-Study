
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/write/write_event.dart';
import 'package:gyeony_diary/bloc/write/write_state.dart';
import 'package:gyeony_diary/repo/write_repo.dart';

class WriteBloc extends Bloc<WriteEvent, WriteState> {
  WriteBloc(WriteRepo detailRepo) : super(WriteLoading());
  WriteRepo detailRepo;

  @override
  Stream<WriteState> mapEventToState(event) async*{
    // if(event is testtest){
    //   yield* _maptesttestToState(event);
    // }
  }
  // Stream<WriteState> _maptesttestToState(DetailEvent event) async*{
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