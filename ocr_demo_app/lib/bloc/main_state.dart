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
  final ui.Rect rect;

  const MainLoaded({this.image, this.file, this.uiImage, this.rect});

  MainLoaded copyWith({Asset image, File file, ui.Image uiImage, ui.Rect rect}) => MainLoaded(
    image: image ?? this.image,
    file:  file ?? this.file,
    uiImage: uiImage ?? this.uiImage,
    rect: rect ?? this.rect,
  );

  @override
  String toString() => '$MainLoaded $image $file $uiImage $rect';
}