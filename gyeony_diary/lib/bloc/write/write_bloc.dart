
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/write/write_event.dart';
import 'package:gyeony_diary/bloc/write/write_state.dart';
import 'package:gyeony_diary/repo/write_repo.dart';

class WriteBloc extends Bloc<WriteEvent, WriteState> {
  WriteBloc(WriteRepo detailRepo) : super(WriteLoaded());
  WriteRepo detailRepo;

  @override
  Stream<WriteState> mapEventToState(event) async*{
    // if(event is testtest){
    //   yield* _maptesttestToState(event);
    // }
    if(event is ChangeContentText){
      if(state is WriteLoaded){
        yield (state as WriteLoaded).copyWith(content: event.content);
      }
    }

    if(event is ChangeImagePath){
      if(state is WriteLoaded){
        yield (state as WriteLoaded).copyWith(imagePath: event.path);

      }
    }


  }

  String getImageUrl(){
    if(state is WriteLoaded){
      return (state as WriteLoaded).imagePath;
    }
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