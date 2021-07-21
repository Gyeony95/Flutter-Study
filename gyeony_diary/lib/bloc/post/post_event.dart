


import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}
class GetDiaryList extends PostEvent {}

class SwitchItemState extends PostEvent {
  final int index;
  const SwitchItemState({ this.index});

  @override
  List<Object> get props => [ index];
}

class DeleteItem extends PostEvent {
  final int id;
  const DeleteItem({this.id});
  @override
  List<Object> get props => [ id];
}

