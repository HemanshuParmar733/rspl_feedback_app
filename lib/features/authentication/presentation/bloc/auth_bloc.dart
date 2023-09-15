import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/shared_pref_keys.dart';
import '../../../../core/database/shared_pref_storage.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/login_with_email_usecase.dart';
import '../../domain/usecases/register_new_user_usecase.dart';
import '../../domain/usecases/signout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailUseCase loginWithEmailUseCase;
  final RegisterNewUserUseCase registerNewUserUseCase;

  final SignOutUseCase signOutUseCase;

  AuthBloc(
      {required this.loginWithEmailUseCase,
      required this.registerNewUserUseCase,
      required this.signOutUseCase})
      : super(const AuthState()) {
    on<OnLoginEvent>(_onLogin);
    on<OnLogOutEvent>(_onLogOut);
    on<OnRegisterEvent>(_onRegister);
    on<OnTogglePasswordVisibilityEvent>(_onPasswordVisibilityChange);
    on<OnToggleConfirmPasswordVisibilityEvent>(
        _onConfirmPasswordVisibilityChange);
  }

  Future<void> _onLogin(OnLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.authLoading));
    final response = await loginWithEmailUseCase.call(
        email: event.email, password: event.password);

    response.fold((l) {
      emit(state.copyWith(
          authStatus: AuthStatus.authFailure,
          errorMsg: 'Invalid credentials, Please try again.'));
    }, (bool isSuccess) {
      if (isSuccess) {
        SharedPrefStorage.instance
            .setBoolData(key: SharedPrefKeys.userLoginKey, data: isSuccess);
        emit(state.copyWith(isLogin: true, authStatus: AuthStatus.authSuccess));
      }
    });
  }

  Future<void> _onRegister(
      OnRegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.authLoading));
    final response = await registerNewUserUseCase.call(
        email: event.email,
        password: event.password,
        userModel: event.userModel);
    response.fold((l) {
      emit(state.copyWith(
          authStatus: AuthStatus.authFailure,
          errorMsg: 'Unable to create user, try with different email.'));
    }, (bool isCreated) {
      if (isCreated) {
        SharedPrefStorage.instance
            .setBoolData(key: SharedPrefKeys.userLoginKey, data: isCreated);
        emit(state.copyWith(
            isRegister: true, authStatus: AuthStatus.authSuccess));
      }
    });
  }

  void _onPasswordVisibilityChange(
      OnTogglePasswordVisibilityEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        obscurePassword: !event.value, authStatus: AuthStatus.authSuccess));
  }

  void _onConfirmPasswordVisibilityChange(
      OnToggleConfirmPasswordVisibilityEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        obscureConfirmPassword: !event.value,
        authStatus: AuthStatus.authSuccess));
  }

  Future<void> _onLogOut(OnLogOutEvent event, Emitter<AuthState> emit) async {
    try {
      await SharedPrefStorage.instance
          .deleteData(key: SharedPrefKeys.userLoginKey);
      await signOutUseCase.call();
      emit(state.copyWith(authStatus: AuthStatus.authSuccess));
    } catch (e) {
      debugPrint('Exception: logout => $e');
      emit(state.copyWith(
          authStatus: AuthStatus.authFailure,
          errorMsg: 'Error while logging out.'));
    }
  }
}
