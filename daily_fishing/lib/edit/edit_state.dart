
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum EditStatus { initial, success, failure }

class EditState extends Equatable {
  const EditState({
    this.status = EditStatus.initial,
    this.filePath
  });

  final EditStatus status;
  final Uint8List filePath;

  EditState copyWith({
    EditStatus status,
    Uint8List filePath,
  }) {
    return EditState(
        status: status ?? this.status,
        filePath: filePath ?? this.filePath
    );
  }

  @override
  List<Object> get props => [status, filePath];
}
