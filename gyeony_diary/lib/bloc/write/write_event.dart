import 'package:equatable/equatable.dart';

abstract class WriteEvent extends Equatable {
  const WriteEvent();

  @override
  List<Object> get props => [];
}
class ChangeContentText extends WriteEvent {
  final String content;
  const ChangeContentText({this.content});

  @override
  List<Object> get props => [ content];
}
