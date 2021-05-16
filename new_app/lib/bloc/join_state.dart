import 'package:equatable/equatable.dart';

abstract class JoinState extends Equatable {
  const JoinState();

  @override
  List<Object> get props => [];
}

class JoinLoading extends JoinState {}
