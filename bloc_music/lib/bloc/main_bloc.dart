import 'package:bloc/bloc.dart';
import 'package:bloc_music/model/music_list_model.dart';
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
  Stream<MainState> mapEventToState(MainEvent event) async*{

    if(event is GetMusicList){
      yield await _mapTest(state);
    }
  }

  Future<MainState> _mapTest(MainState state) async{

    List<MusicListModel> mList = [];
    mList.add(MusicListModel(title: 'title1', imgUrl: 'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F1465CA1D4C6274DAB0'));
    mList.add(MusicListModel(title: 'title2', imgUrl: 'https://t1.daumcdn.net/cfile/tistory/995EC54A5EFBEF222C'));
    mList.add(MusicListModel(title: 'title3', imgUrl: 'http://www.jeonmin.co.kr/news/photo/201605/151369_18706_4151.jpg'));
    mList.add(MusicListModel(title: 'title3', imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwvGEHHjaSDC84jHytzpRjX9_b0r80bX16uQ&usqp=CAU'));
    mList.add(MusicListModel(title: 'title5', imgUrl: 'https://thumbnail.forsnap.com/normal/crop/320x320/product/5a/1936/portfolio5c6d07d1adc9d.jpg'));
    mList.add(MusicListModel(title: 'title6', imgUrl: 'https://image.edaily.co.kr/images/Photo/files/NP/S/2013/08/PS13080100109.jpg'));
    mList.add(MusicListModel(title: 'title7', imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv2CRUwHAUGleRj4r-AYsvy5rCyuXqigUHjg&usqp=CAU'));

    return state.copyWith(
      status: MainStatus.loaded,
      lists: mList,
    );

  }

}