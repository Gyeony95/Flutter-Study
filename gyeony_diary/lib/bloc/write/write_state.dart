import 'package:equatable/equatable.dart';
import 'package:gyeony_diary/model/detail_model.dart';

abstract class WriteState extends Equatable {
  const WriteState();

  @override
  List<Object> get props => [];
}

class WriteLoading extends WriteState {}

class WriteLoaded extends WriteState {
  final List<ImageModel> list;

  const WriteLoaded({
    this.list
  });

  WriteLoaded copyWith({List<ImageModel> list}) =>
      WriteLoaded(
        list: list ?? this.list,
      );
}
