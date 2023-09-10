// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? obscurePassword,
            bool? obscureConfirmPassword,
            bool? isRegister,
            bool? isLogin,
            bool? isLoading)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthFailure value) failure,
    required TResult Function(AuthSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthFailure value)? failure,
    TResult? Function(AuthSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthFailure value)? failure,
    TResult Function(AuthSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthInitialCopyWith<$Res> {
  factory _$$AuthInitialCopyWith(
          _$AuthInitial value, $Res Function(_$AuthInitial) then) =
      __$$AuthInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthInitialCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitial>
    implements _$$AuthInitialCopyWith<$Res> {
  __$$AuthInitialCopyWithImpl(
      _$AuthInitial _value, $Res Function(_$AuthInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthInitial implements AuthInitial {
  const _$AuthInitial();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? obscurePassword,
            bool? obscureConfirmPassword,
            bool? isRegister,
            bool? isLogin,
            bool? isLoading)
        success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthFailure value) failure,
    required TResult Function(AuthSuccess value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthFailure value)? failure,
    TResult? Function(AuthSuccess value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthFailure value)? failure,
    TResult Function(AuthSuccess value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitial;
}

/// @nodoc
abstract class _$$AuthFailureCopyWith<$Res> {
  factory _$$AuthFailureCopyWith(
          _$AuthFailure value, $Res Function(_$AuthFailure) then) =
      __$$AuthFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String? errorMsg});
}

/// @nodoc
class __$$AuthFailureCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthFailure>
    implements _$$AuthFailureCopyWith<$Res> {
  __$$AuthFailureCopyWithImpl(
      _$AuthFailure _value, $Res Function(_$AuthFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = freezed,
  }) {
    return _then(_$AuthFailure(
      errorMsg: freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthFailure implements AuthFailure {
  const _$AuthFailure({this.errorMsg});

  @override
  final String? errorMsg;

  @override
  String toString() {
    return 'AuthState.failure(errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailure &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureCopyWith<_$AuthFailure> get copyWith =>
      __$$AuthFailureCopyWithImpl<_$AuthFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? obscurePassword,
            bool? obscureConfirmPassword,
            bool? isRegister,
            bool? isLogin,
            bool? isLoading)
        success,
  }) {
    return failure(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
  }) {
    return failure?.call(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMsg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthFailure value) failure,
    required TResult Function(AuthSuccess value) success,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthFailure value)? failure,
    TResult? Function(AuthSuccess value)? success,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthFailure value)? failure,
    TResult Function(AuthSuccess value)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class AuthFailure implements AuthState {
  const factory AuthFailure({final String? errorMsg}) = _$AuthFailure;

  String? get errorMsg;
  @JsonKey(ignore: true)
  _$$AuthFailureCopyWith<_$AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSuccessCopyWith<$Res> {
  factory _$$AuthSuccessCopyWith(
          _$AuthSuccess value, $Res Function(_$AuthSuccess) then) =
      __$$AuthSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool? obscurePassword,
      bool? obscureConfirmPassword,
      bool? isRegister,
      bool? isLogin,
      bool? isLoading});
}

/// @nodoc
class __$$AuthSuccessCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthSuccess>
    implements _$$AuthSuccessCopyWith<$Res> {
  __$$AuthSuccessCopyWithImpl(
      _$AuthSuccess _value, $Res Function(_$AuthSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obscurePassword = freezed,
    Object? obscureConfirmPassword = freezed,
    Object? isRegister = freezed,
    Object? isLogin = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$AuthSuccess(
      obscurePassword: freezed == obscurePassword
          ? _value.obscurePassword
          : obscurePassword // ignore: cast_nullable_to_non_nullable
              as bool?,
      obscureConfirmPassword: freezed == obscureConfirmPassword
          ? _value.obscureConfirmPassword
          : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRegister: freezed == isRegister
          ? _value.isRegister
          : isRegister // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLogin: freezed == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$AuthSuccess implements AuthSuccess {
  const _$AuthSuccess(
      {this.obscurePassword,
      this.obscureConfirmPassword,
      this.isRegister,
      this.isLogin,
      this.isLoading});

  @override
  final bool? obscurePassword;
  @override
  final bool? obscureConfirmPassword;
  @override
  final bool? isRegister;
  @override
  final bool? isLogin;
  @override
  final bool? isLoading;

  @override
  String toString() {
    return 'AuthState.success(obscurePassword: $obscurePassword, obscureConfirmPassword: $obscureConfirmPassword, isRegister: $isRegister, isLogin: $isLogin, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSuccess &&
            (identical(other.obscurePassword, obscurePassword) ||
                other.obscurePassword == obscurePassword) &&
            (identical(other.obscureConfirmPassword, obscureConfirmPassword) ||
                other.obscureConfirmPassword == obscureConfirmPassword) &&
            (identical(other.isRegister, isRegister) ||
                other.isRegister == isRegister) &&
            (identical(other.isLogin, isLogin) || other.isLogin == isLogin) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, obscurePassword,
      obscureConfirmPassword, isRegister, isLogin, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSuccessCopyWith<_$AuthSuccess> get copyWith =>
      __$$AuthSuccessCopyWithImpl<_$AuthSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? obscurePassword,
            bool? obscureConfirmPassword,
            bool? isRegister,
            bool? isLogin,
            bool? isLoading)
        success,
  }) {
    return success(obscurePassword, obscureConfirmPassword, isRegister, isLogin,
        isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
  }) {
    return success?.call(obscurePassword, obscureConfirmPassword, isRegister,
        isLogin, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(bool? obscurePassword, bool? obscureConfirmPassword,
            bool? isRegister, bool? isLogin, bool? isLoading)?
        success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(obscurePassword, obscureConfirmPassword, isRegister,
          isLogin, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthFailure value) failure,
    required TResult Function(AuthSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthFailure value)? failure,
    TResult? Function(AuthSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthFailure value)? failure,
    TResult Function(AuthSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AuthSuccess implements AuthState {
  const factory AuthSuccess(
      {final bool? obscurePassword,
      final bool? obscureConfirmPassword,
      final bool? isRegister,
      final bool? isLogin,
      final bool? isLoading}) = _$AuthSuccess;

  bool? get obscurePassword;
  bool? get obscureConfirmPassword;
  bool? get isRegister;
  bool? get isLogin;
  bool? get isLoading;
  @JsonKey(ignore: true)
  _$$AuthSuccessCopyWith<_$AuthSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
