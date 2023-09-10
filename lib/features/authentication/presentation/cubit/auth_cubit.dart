import 'package:bloc/bloc.dart' show Cubit;
import 'package:feedback_app/core/constants/shared_pref_keys.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/domain/usecases/login_with_email_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/register_new_user_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/database/shared_pref_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());
  final LoginWithEmailUseCase _loginWithEmailUseCase =
      slAuth<LoginWithEmailUseCase>();
  final RegisterNewUserUseCase _registerNewUserUseCase =
      slAuth<RegisterNewUserUseCase>();

  final SignOutUseCase _signOutUseCase = slAuth<SignOutUseCase>();

  void togglePasswordVisibility(bool isObscure) {
    changeSuccessState(passWordObscure: !isObscure);
  }

  void toggleConfirmPasswordVisibility(bool isObscure) {
    changeSuccessState(confirmPassObscure: !isObscure);
  }

  Future<void> registerNewUser(
      {required String email,
      required String password,
      required UserModel model}) async {
    changeSuccessState(isLoading: true);
    final response = await _registerNewUserUseCase.call(
        email: email, password: password, userModel: model);
    response.fold((l) {
      changeSuccessState(isLoading: false);
      debugPrint('Exception: registerNewUser => ${l.toString()}');
      emit(const AuthFailure(
          errorMsg: 'Unable to create user, try with different email.'));
    }, (bool isCreated) {
      if (isCreated) {
        SharedPrefStorage.instance
            .setBoolData(key: SharedPrefKeys.userLoginKey, data: isCreated);
        changeSuccessState(isRegister: true);
      }
    });
  }

  Future<void> loginWithEmailPassword(
      {required String email, required String password}) async {
    changeSuccessState(isLoading: true);
    final response =
        await _loginWithEmailUseCase.call(email: email, password: password);
    changeSuccessState(isLoading: false);

    response.fold((l) {
      debugPrint('Exception: loginWithEmailPassword => ${l.toString()}');
      emit(const AuthFailure(
          errorMsg: 'Invalid credentials, Please try again.'));
    }, (bool isSuccess) {
      if (isSuccess) {
        SharedPrefStorage.instance
            .setBoolData(key: SharedPrefKeys.userLoginKey, data: isSuccess);
        changeSuccessState(isLogin: true);
      }
    });
  }

  bool isUserLoggedIn() {
    return SharedPrefStorage.instance
            .getBoolData(key: SharedPrefKeys.userLoginKey) ??
        false;
  }

  Future<void> logOut() async {
    try {
      await SharedPrefStorage.instance
          .deleteData(key: SharedPrefKeys.userLoginKey);
      await _signOutUseCase.call();
    } catch (e) {
      debugPrint('Exception: logout => $e');
      emit(const AuthFailure(errorMsg: 'Error while logging out.'));
    }
  }

  void changeSuccessState(
      {bool? passWordObscure,
      bool? confirmPassObscure,
      bool? isLogin,
      bool? isRegister,
      bool? isLoading}) {
    if (state is AuthSuccess) {
      final currentState = state as AuthSuccess;
      emit(currentState.copyWith(
          obscurePassword: passWordObscure ?? currentState.obscurePassword,
          obscureConfirmPassword:
              confirmPassObscure ?? currentState.obscureConfirmPassword,
          isRegister: isRegister ?? currentState.isRegister,
          isLogin: isLogin ?? currentState.isLogin,
          isLoading: isLoading ?? currentState.isLoading));
    } else {
      emit(AuthSuccess(
          obscurePassword: passWordObscure ?? true,
          obscureConfirmPassword: confirmPassObscure ?? true,
          isLogin: isLogin ?? false,
          isRegister: isRegister ?? false,
          isLoading: isLoading));
    }
  }
}
