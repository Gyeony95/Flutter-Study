import 'package:equatable/equatable.dart';
import 'package:gyeony_diary/model/detail_model.dart';

abstract class WriteState extends Equatable {
  const WriteState();

  @override
  List<Object> get props => [];
}

class WriteLoading extends WriteState {}

class WriteLoaded extends WriteState {
  final String content;
  final String imagePath;

  const WriteLoaded({
    this.content,
    this.imagePath,
  });

  WriteLoaded copyWith({String content, String imagePath}) =>
      WriteLoaded(
        content: content ?? this.content,
        imagePath: imagePath ?? this.imagePath,
      );

  // WriteLoaded setContent({String content}){
  //   return copyWith(content: content);
  // }


}


