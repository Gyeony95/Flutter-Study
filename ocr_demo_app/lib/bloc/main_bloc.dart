
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_demo_app/bloc/main_event.dart';

import '../main_repo.dart';
import 'main_state.dart';
import 'dart:ui' as ui;

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainRepo mainRepo) : super(MainLoading());
  MainRepo mainRepo;


  @override
  Stream<MainState> mapEventToState(event) async*{
    if(event is GetImageData){
      yield* _mapGetImageDataToState(event);
    }
  }
  Stream<MainState> _mapGetImageDataToState(MainEvent event) async*{
    var currentEvent = event as GetImageData;

    // var currentState =( state as MainLoaded).copyWith(file: currentEvent.file, image: currentEvent.image, uiImage: currentEvent.uiImage);
    log('ghgh 12'+currentEvent.uiImage.width.toString());
    // log('ghgh 13'+currentState.uiImage.width.toString());

    // yield currentState.copyWith(file: currentEvent.file, image: currentEvent.image, uiImage: currentEvent.uiImage);
    yield MainLoaded(image: currentEvent.image, file: currentEvent.file, uiImage: currentEvent.uiImage);


  }

}