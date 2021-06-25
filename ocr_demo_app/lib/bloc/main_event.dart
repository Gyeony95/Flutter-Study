import 'dart:io';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:ui' as ui;

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}
class GetImageData extends MainEvent {
  final Asset image;
  final File file;
  final ui.Image uiImage;
  final Rect rect;

  const GetImageData(this.image, this.file, this.uiImage,this.rect);

  @override
  String toString() => '$GetImageData $image $file $uiImage $rect';

  @override
  List<Object> get props => [image,file,uiImage,rect];

}

// class SetRect extends MainEvent{
//   final Rect rect;
//
//   const SetRect(this.rect);
//
//   @override
//   String toString() => '$SetRect $rect';
//
//   @override
//   List<Object> get props => [rect];
//
// }