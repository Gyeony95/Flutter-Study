import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/main_state.dart';
import 'package:gyeony_diary/bloc/post/post_event.dart';
import 'package:gyeony_diary/bloc/post/post_state.dart';
import 'package:gyeony_diary/model/post_model.dart';
import 'package:gyeony_diary/provider/post_provider.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'package:gyeony_diary/repo/post_repo.dart';
import '../main_event.dart';

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
    if(event is DeleteItem){
      yield* _mapDeleteItemStateToState(event);

    }
  }

  Stream<PostState> _mapGetDiaryListToState(PostEvent event) async*{
    yield PostLoading();
    //여기서 데이터 얻어옴
    var provider = PostProvider();
    var postList = await provider.getPostList();
    log('GHGHGH postList : '+postList.toString());
    List<PostModel> addedList = [];
    for(var i =0; i < postList.length; i++){
      addedList.add(postList[i].copyWith(isOpened: false));
    }
    yield PostLoaded(list: addedList);
  }

  Stream<PostState> _mapDeleteItemStateToState(PostEvent event) async*{
    yield PostLoading();
    //여기서 데이터 얻어옴
    var provider = PostProvider();
    await provider.delete((event as DeleteItem).id).then((value) => add(GetDiaryList())) ;
    // add(GetDiaryList());
    // yield PostLoaded(list: addedList);
  }

  Stream<PostState> _mapSwitchItemStateToState(PostEvent event) async*{
    yield PostLoading();

    var currentEvent = (event as SwitchItemState);
    var currentState = (state as PostLoaded).copyWith(
        list: (state as PostLoaded).list.asMap().entries.map((entry) {
          int idx = entry.key;
          return idx ==currentEvent.index ? entry.value.copyWith(isOpened: (state as PostLoaded).list[currentEvent.index].isOpened ? false : true) :  entry.value;
        }).toList()
    );

    yield PostLoaded(list: currentState.list);
  }

  // Future<void> _getListFromDB() async {
  //   var provider = PostProvider();
  //   provider.getPostList();
  // }
}