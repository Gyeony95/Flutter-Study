import 'package:equatable/equatable.dart';
import 'package:gyeony_diary/model/chart_model.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final List<RadialData> list;

  const MainLoaded({
    this.list
  });

  MainLoaded copyWith({List<RadialData> list}) =>
      MainLoaded(
        list: list ?? this.list,
      );
}
