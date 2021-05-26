
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyeony_diary/repo/detail_repo.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(DetailRepo detailRepo) : super(DetailLoading());
  DetailRepo detailRepo;

  @override
  Stream<DetailState> mapEventToState(event) async*{

  }


}