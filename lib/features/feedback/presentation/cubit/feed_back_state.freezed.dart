// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_back_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedbackState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
        success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedbackInitial value) initial,
    required TResult Function(FeedbackFailure value) failure,
    required TResult Function(FeedbackSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedbackInitial value)? initial,
    TResult? Function(FeedbackFailure value)? failure,
    TResult? Function(FeedbackSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedbackInitial value)? initial,
    TResult Function(FeedbackFailure value)? failure,
    TResult Function(FeedbackSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackStateCopyWith<$Res> {
  factory $FeedbackStateCopyWith(
          FeedbackState value, $Res Function(FeedbackState) then) =
      _$FeedbackStateCopyWithImpl<$Res, FeedbackState>;
}

/// @nodoc
class _$FeedbackStateCopyWithImpl<$Res, $Val extends FeedbackState>
    implements $FeedbackStateCopyWith<$Res> {
  _$FeedbackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FeedbackInitialCopyWith<$Res> {
  factory _$$FeedbackInitialCopyWith(
          _$FeedbackInitial value, $Res Function(_$FeedbackInitial) then) =
      __$$FeedbackInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FeedbackInitialCopyWithImpl<$Res>
    extends _$FeedbackStateCopyWithImpl<$Res, _$FeedbackInitial>
    implements _$$FeedbackInitialCopyWith<$Res> {
  __$$FeedbackInitialCopyWithImpl(
      _$FeedbackInitial _value, $Res Function(_$FeedbackInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FeedbackInitial implements FeedbackInitial {
  const _$FeedbackInitial();

  @override
  String toString() {
    return 'FeedbackState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FeedbackInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)
        success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
        success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
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
    required TResult Function(FeedbackInitial value) initial,
    required TResult Function(FeedbackFailure value) failure,
    required TResult Function(FeedbackSuccess value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedbackInitial value)? initial,
    TResult? Function(FeedbackFailure value)? failure,
    TResult? Function(FeedbackSuccess value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedbackInitial value)? initial,
    TResult Function(FeedbackFailure value)? failure,
    TResult Function(FeedbackSuccess value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FeedbackInitial implements FeedbackState {
  const factory FeedbackInitial() = _$FeedbackInitial;
}

/// @nodoc
abstract class _$$FeedbackFailureCopyWith<$Res> {
  factory _$$FeedbackFailureCopyWith(
          _$FeedbackFailure value, $Res Function(_$FeedbackFailure) then) =
      __$$FeedbackFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String? errorMsg});
}

/// @nodoc
class __$$FeedbackFailureCopyWithImpl<$Res>
    extends _$FeedbackStateCopyWithImpl<$Res, _$FeedbackFailure>
    implements _$$FeedbackFailureCopyWith<$Res> {
  __$$FeedbackFailureCopyWithImpl(
      _$FeedbackFailure _value, $Res Function(_$FeedbackFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = freezed,
  }) {
    return _then(_$FeedbackFailure(
      errorMsg: freezed == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FeedbackFailure implements FeedbackFailure {
  const _$FeedbackFailure({this.errorMsg});

  @override
  final String? errorMsg;

  @override
  String toString() {
    return 'FeedbackState.failure(errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackFailure &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackFailureCopyWith<_$FeedbackFailure> get copyWith =>
      __$$FeedbackFailureCopyWithImpl<_$FeedbackFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)
        success,
  }) {
    return failure(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
        success,
  }) {
    return failure?.call(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
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
    required TResult Function(FeedbackInitial value) initial,
    required TResult Function(FeedbackFailure value) failure,
    required TResult Function(FeedbackSuccess value) success,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedbackInitial value)? initial,
    TResult? Function(FeedbackFailure value)? failure,
    TResult? Function(FeedbackSuccess value)? success,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedbackInitial value)? initial,
    TResult Function(FeedbackFailure value)? failure,
    TResult Function(FeedbackSuccess value)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FeedbackFailure implements FeedbackState {
  const factory FeedbackFailure({final String? errorMsg}) = _$FeedbackFailure;

  String? get errorMsg;
  @JsonKey(ignore: true)
  _$$FeedbackFailureCopyWith<_$FeedbackFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FeedbackSuccessCopyWith<$Res> {
  factory _$$FeedbackSuccessCopyWith(
          _$FeedbackSuccess value, $Res Function(_$FeedbackSuccess) then) =
      __$$FeedbackSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool? isAnonymous,
      bool? isFeedbackCreate,
      bool? isLoading,
      bool? isUpdatingFeedback,
      String? username,
      String? selectedCategory,
      List<String>? feedbackCategories});
}

/// @nodoc
class __$$FeedbackSuccessCopyWithImpl<$Res>
    extends _$FeedbackStateCopyWithImpl<$Res, _$FeedbackSuccess>
    implements _$$FeedbackSuccessCopyWith<$Res> {
  __$$FeedbackSuccessCopyWithImpl(
      _$FeedbackSuccess _value, $Res Function(_$FeedbackSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnonymous = freezed,
    Object? isFeedbackCreate = freezed,
    Object? isLoading = freezed,
    Object? isUpdatingFeedback = freezed,
    Object? username = freezed,
    Object? selectedCategory = freezed,
    Object? feedbackCategories = freezed,
  }) {
    return _then(_$FeedbackSuccess(
      isAnonymous: freezed == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFeedbackCreate: freezed == isFeedbackCreate
          ? _value.isFeedbackCreate
          : isFeedbackCreate // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      isUpdatingFeedback: freezed == isUpdatingFeedback
          ? _value.isUpdatingFeedback
          : isUpdatingFeedback // ignore: cast_nullable_to_non_nullable
              as bool?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      feedbackCategories: freezed == feedbackCategories
          ? _value._feedbackCategories
          : feedbackCategories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$FeedbackSuccess implements FeedbackSuccess {
  const _$FeedbackSuccess(
      {this.isAnonymous,
      this.isFeedbackCreate,
      this.isLoading,
      this.isUpdatingFeedback,
      this.username,
      this.selectedCategory,
      final List<String>? feedbackCategories})
      : _feedbackCategories = feedbackCategories;

  @override
  final bool? isAnonymous;
  @override
  final bool? isFeedbackCreate;
  @override
  final bool? isLoading;
  @override
  final bool? isUpdatingFeedback;
  @override
  final String? username;
  @override
  final String? selectedCategory;
  final List<String>? _feedbackCategories;
  @override
  List<String>? get feedbackCategories {
    final value = _feedbackCategories;
    if (value == null) return null;
    if (_feedbackCategories is EqualUnmodifiableListView)
      return _feedbackCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FeedbackState.success(isAnonymous: $isAnonymous, isFeedbackCreate: $isFeedbackCreate, isLoading: $isLoading, isUpdatingFeedback: $isUpdatingFeedback, username: $username, selectedCategory: $selectedCategory, feedbackCategories: $feedbackCategories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackSuccess &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.isFeedbackCreate, isFeedbackCreate) ||
                other.isFeedbackCreate == isFeedbackCreate) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUpdatingFeedback, isUpdatingFeedback) ||
                other.isUpdatingFeedback == isUpdatingFeedback) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            const DeepCollectionEquality()
                .equals(other._feedbackCategories, _feedbackCategories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isAnonymous,
      isFeedbackCreate,
      isLoading,
      isUpdatingFeedback,
      username,
      selectedCategory,
      const DeepCollectionEquality().hash(_feedbackCategories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackSuccessCopyWith<_$FeedbackSuccess> get copyWith =>
      __$$FeedbackSuccessCopyWithImpl<_$FeedbackSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? errorMsg) failure,
    required TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)
        success,
  }) {
    return success(isAnonymous, isFeedbackCreate, isLoading, isUpdatingFeedback,
        username, selectedCategory, feedbackCategories);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? errorMsg)? failure,
    TResult? Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
        success,
  }) {
    return success?.call(isAnonymous, isFeedbackCreate, isLoading,
        isUpdatingFeedback, username, selectedCategory, feedbackCategories);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? errorMsg)? failure,
    TResult Function(
            bool? isAnonymous,
            bool? isFeedbackCreate,
            bool? isLoading,
            bool? isUpdatingFeedback,
            String? username,
            String? selectedCategory,
            List<String>? feedbackCategories)?
        success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(isAnonymous, isFeedbackCreate, isLoading,
          isUpdatingFeedback, username, selectedCategory, feedbackCategories);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FeedbackInitial value) initial,
    required TResult Function(FeedbackFailure value) failure,
    required TResult Function(FeedbackSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FeedbackInitial value)? initial,
    TResult? Function(FeedbackFailure value)? failure,
    TResult? Function(FeedbackSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FeedbackInitial value)? initial,
    TResult Function(FeedbackFailure value)? failure,
    TResult Function(FeedbackSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class FeedbackSuccess implements FeedbackState {
  const factory FeedbackSuccess(
      {final bool? isAnonymous,
      final bool? isFeedbackCreate,
      final bool? isLoading,
      final bool? isUpdatingFeedback,
      final String? username,
      final String? selectedCategory,
      final List<String>? feedbackCategories}) = _$FeedbackSuccess;

  bool? get isAnonymous;
  bool? get isFeedbackCreate;
  bool? get isLoading;
  bool? get isUpdatingFeedback;
  String? get username;
  String? get selectedCategory;
  List<String>? get feedbackCategories;
  @JsonKey(ignore: true)
  _$$FeedbackSuccessCopyWith<_$FeedbackSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
