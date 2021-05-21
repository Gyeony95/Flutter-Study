


import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

//그날 다이어리 작성 현황
class GetDailyDiaryData extends MainEvent {}
