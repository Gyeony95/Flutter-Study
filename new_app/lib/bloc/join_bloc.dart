
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/repo/join_repo.dart';

import 'join_event.dart';
import 'join_state.dart';

class JoinBloc extends Bloc<JoinEvent, JoinState> {
  JoinBloc(JoinRepo joinRepo) : super(JoinLoading());
  JoinRepo joinRepo;

  @override
  Stream<JoinState> mapEventToState(event) {


  }


}