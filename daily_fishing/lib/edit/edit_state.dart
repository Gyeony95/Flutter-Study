
import 'package:equatable/equatable.dart';

enum EditStatus { initial, success, failure }

class EditState extends Equatable {
  const EditState({
    this.status = EditStatus.initial,
  });

  final EditStatus status;

  EditState copyWith({
    EditStatus status,
  }) {
    return EditState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
