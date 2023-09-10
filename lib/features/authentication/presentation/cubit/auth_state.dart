import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.failure({String? errorMsg}) = AuthFailure;

  const factory AuthState.success(
      {bool? obscurePassword,
      bool? obscureConfirmPassword,
      bool? isRegister,
      bool? isLogin,
      bool? isLoading}) = AuthSuccess;
}
