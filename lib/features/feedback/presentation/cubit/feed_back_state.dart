import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_back_state.freezed.dart';

@freezed
abstract class FeedbackState with _$FeedbackState {
  const factory FeedbackState.initial() = FeedbackInitial;

  const factory FeedbackState.failure({String? errorMsg}) = FeedbackFailure;

  const factory FeedbackState.success(
      {bool? isAnonymous,
      bool? isFeedbackCreate,
      bool? isLoading,
      bool? isUpdatingFeedback,
      String? username,
      String? selectedCategory,
      List<String>? feedbackCategories}) = FeedbackSuccess;
}
