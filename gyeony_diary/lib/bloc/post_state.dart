import 'package:equatable/equatable.dart';
import 'package:gyeony_diary/model/post_model.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> list;

  const PostLoaded({
    this.list
  });

  PostLoaded copyWith({List<PostModel> list}) =>
      PostLoaded(
        list: list ?? this.list,
      );

}
