part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final String userId;
  final String userPw;

  const LoginInitial({
    this.userId,
    this.userPw,
  });

  LoginInitial copyWith({
    String userId,
    String userPw,
  }) =>
      LoginInitial(
        userId: userId ?? this.userId,
        userPw: userPw ?? this.userPw,
      );

  bool get isValid => userId?.isNotEmpty == true && userPw?.isNotEmpty == true;

  @override
  List<Object> get props => [
    userId,
    userPw,
  ];

  @override
  String toString() => '''$LoginInitial {
    userId: $userId,
    userPw: $userPw,
  }''';
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';

  @override
  List<Object> get props => [error];
}
