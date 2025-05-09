part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final String token;

  AuthSuccess(this.user, this.token);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthLogout extends AuthState {}

class AuthLoaded extends AuthState {
  final UserModel user;
  AuthLoaded(this.user);
}
