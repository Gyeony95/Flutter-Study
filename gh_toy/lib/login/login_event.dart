part of 'login_bloc.dart';
@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}



class LoginButtonPressed extends LoginEvent {
  final userId;
  final userPw;

  const LoginButtonPressed({
    @required this.userId,
    @required this.userPw,
  })  : assert(userId != null),
        assert(userPw != null);

  @override
  String toString() => 'LoginButtonPressed userId: $userId, userPw: $userPw';

  @override
  List<Object> get props => [userId, userPw];
}
