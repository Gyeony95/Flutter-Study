import 'dart:io';

import 'package:equatable/equatable.dart';
import 'dart:ui' as ui;

import 'package:multi_image_picker/multi_image_picker.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final Asset image;
  final File file;
  final ui.Image uiImage;

  const MainLoaded({this.image, this.file, this.uiImage});

  MainLoaded copyWith({Asset image, File file, ui.Image uiImage}) => MainLoaded(
    image: image ?? this.image,
    file:  file ?? this.file,
    uiImage: uiImage ?? this.uiImage,
  );

  // final List<ImageModel> list;
  //
  // const DetailLoaded({
  //   this.list
  // });
  //
  // DetailLoaded copyWith({List<ImageModel> list}) =>
  //     DetailLoaded(
  //       list: list ?? this.list,
  //     );
}