part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResult loginResult;
  const LoginLoaded({
    required this.loginResult,
  });

  @override
  List<Object> get props => [loginResult];
}

class LoginError extends LoginState {
  final String message;
  const LoginError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
