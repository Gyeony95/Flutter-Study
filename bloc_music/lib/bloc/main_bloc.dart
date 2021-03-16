import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';


part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState>{
  MainBloc({this.httpClient}) : super(MainState());

  final http.Client httpClient;


  @override
  Stream<MainState> mapEventToState(MainEvent event) {

    if(event is GetMusicList){
      debugPrint('GetMusicList');
    }

  }

}