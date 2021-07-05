import 'package:equatable/equatable.dart';

abstract class GridItemEvent extends Equatable {
  const GridItemEvent();

  @override
  List<Object> get props => [];
}
class GetImageList extends GridItemEvent {}
