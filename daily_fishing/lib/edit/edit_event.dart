

import 'package:equatable/equatable.dart';

abstract class EditEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateImage extends EditEvent {}
