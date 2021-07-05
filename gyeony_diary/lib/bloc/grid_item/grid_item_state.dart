import 'package:equatable/equatable.dart';
import 'package:gyeony_diary/model/detail_model.dart';

abstract class GridItemState extends Equatable {
  const GridItemState();

  @override
  List<Object> get props => [];
}

class GridItemLoading extends GridItemState {}

class GridItemLoaded extends GridItemState {
  final List<ImageModel> list;

  const GridItemLoaded({
    this.list
  });

  GridItemLoaded copyWith({List<ImageModel> list}) =>
      GridItemLoaded(
        list: list ?? this.list,
      );
}
