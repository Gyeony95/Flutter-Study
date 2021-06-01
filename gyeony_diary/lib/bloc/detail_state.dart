import 'package:equatable/equatable.dart';
import 'package:gyeony_diary/model/detail_model.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final List<ImageModel> list;

  const DetailLoaded({
    this.list
  });

  DetailLoaded copyWith({List<ImageModel> list}) =>
      DetailLoaded(
        list: list ?? this.list,
      );
}
