

import 'package:equatable/equatable.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();
  @override
  List<Object> get props => [];
}

class FilePick extends EditEvent{}

// class UpdateImage extends EditEvent {
//   final String filePath;
//
//   const UpdateImage({this.filePath});
//
//   @override
//   List<Object> get props => [filePath];
// }
