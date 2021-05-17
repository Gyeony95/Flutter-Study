import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/bloc/main_state.dart';
import 'package:gyeony_diary/bloc/post_event.dart';
import 'package:gyeony_diary/bloc/post_state.dart';
import 'package:gyeony_diary/repo/main_repo.dart';
import 'package:gyeony_diary/repo/post_repo.dart';
import 'main_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(PostRepo postRepo) : super(PostLoading());
  PostRepo postRepo;

  @override
  Stream<PostState> mapEventToState(event) {


  }


}