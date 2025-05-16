part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });
}

class LogoutEvent extends AuthEvent {}

class FetchCurrentUser extends AuthEvent {}

class UpdateProfile extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final Uint8List? photo;
  final String? photoFilename;

  UpdateProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    this.photoFilename,
  });
}
