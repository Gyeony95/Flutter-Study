
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
    // if(event is SetRect){
    //   yield* _mapSetRectToState(event);
    // }


  }
  Stream<MainState> _mapGetImageDataToState(MainEvent event) async*{
    var currentEvent = event as GetImageData;

    yield MainLoaded(image: currentEvent.image, file: currentEvent.file, uiImage: currentEvent.uiImage, rect: currentEvent.rect);
  }
  // Stream<MainState> _mapSetRectToState(MainEvent event) async*{
  //   var currentEvent = event as SetRect;
  //   var currentState = state as MainLoaded;
  //   yield currentState.copyWith(rect: currentEvent.rect);
  //   log('ghghgh setRect :'+currentEvent.rect.width.toString());
  //
  //   yield MainLoaded(image: currentState.image, file: currentState.file, uiImage: currentState.uiImage, rect: currentEvent.rect);
  // }

}