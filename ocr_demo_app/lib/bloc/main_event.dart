import 'dart:io';

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

  const GetImageData(this.image, this.file, this.uiImage);

  @override
  String toString() => '$GetImageData $image $file $uiImage';

  @override
  List<Object> get props => [image,file,uiImage];

}