import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_toy/post/post_event.dart';
import 'package:gh_toy/post/post_state.dart';



class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostLoading());


  @override
  Stream<PostState> mapEventToState(
      PostEvent event,
      ) async* {
    // if (event is LoginButtonPressed) {
    //   yield LoginLoading();
    //   try {
    //     yield LoginSuccess();
    //   } catch (error) {
    //     yield LoginFailure(error: error.toString());
    //   }
    // }


  }
}
