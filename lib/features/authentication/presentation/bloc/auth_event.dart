part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class OnTogglePasswordVisibilityEvent extends AuthEvent {
  final bool value;

  const OnTogglePasswordVisibilityEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class OnToggleConfirmPasswordVisibilityEvent extends AuthEvent {
  final bool value;

  const OnToggleConfirmPasswordVisibilityEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class OnLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const OnLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class OnRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final UserModel userModel;

  const OnRegisterEvent(
      {required this.email, required this.password, required this.userModel});

  @override
  List<Object?> get props => [email, password, userModel.uid];
}

class OnLogOutEvent extends AuthEvent {
  const OnLogOutEvent();
}
