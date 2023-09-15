part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool? obscurePassword;
  final bool? obscureConfirmPassword;
  final bool? isRegister;
  final bool? isLogin;
  final String? errorMsg;
  final AuthStatus authStatus;

  const AuthState(
      {this.obscurePassword,
      this.obscureConfirmPassword,
      this.isRegister,
      this.isLogin,
      this.errorMsg,
      this.authStatus = AuthStatus.authInitial});

  @override
  List<Object?> get props => [
        obscureConfirmPassword,
        obscurePassword,
        isRegister,
        isLogin,
        authStatus,
        errorMsg
      ];

  AuthState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? isRegister,
    bool? isLogin,
    String? errorMsg,
    AuthStatus? authStatus,
  }) {
    return AuthState(
        obscureConfirmPassword:
            obscureConfirmPassword ?? this.obscureConfirmPassword,
        obscurePassword: obscurePassword ?? this.obscurePassword,
        isRegister: isRegister ?? this.isRegister,
        isLogin: isLogin ?? this.isLogin,
        errorMsg: errorMsg ?? this.errorMsg,
        authStatus: authStatus ?? this.authStatus);
  }
}

enum AuthStatus { authInitial, authLoading, authSuccess, authFailure }
