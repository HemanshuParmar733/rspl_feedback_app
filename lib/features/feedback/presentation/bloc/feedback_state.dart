part of 'feedback_bloc.dart';

class FeedbackState extends Equatable {
  final bool? isAnonymous;
  final bool? isFeedbackCreate;
  final FeedbackStatus paginationStatus;
  final FeedbackStatus feedbackListStatus;
  final FeedbackStatus feedbackCategoryStatus;
  final bool isUpdatingFeedback;
  final String? username;
  final String? selectedCategory;
  final String? failureMsg;
  final List<String>? feedbackCategories;
  final List<FeedbackModel>? feedbackModelList;

  const FeedbackState(
      {this.isAnonymous,
      this.isFeedbackCreate,
      this.paginationStatus = FeedbackStatus.feedbackInitial,
      this.feedbackListStatus = FeedbackStatus.feedbackInitial,
      this.feedbackCategoryStatus = FeedbackStatus.feedbackInitial,
      this.isUpdatingFeedback = false,
      this.username,
      this.failureMsg,
      this.selectedCategory,
      this.feedbackCategories,
      this.feedbackModelList});

  @override
  List<Object?> get props => [
        isAnonymous,
        isFeedbackCreate,
        paginationStatus,
        feedbackListStatus,
        isUpdatingFeedback,
        feedbackCategoryStatus,
        username,
        failureMsg,
        selectedCategory,
        feedbackCategories,
        feedbackModelList,
      ];

  FeedbackState copyWith(
      {bool? isAnonymous,
      bool? isFeedbackCreate,
      FeedbackStatus? paginationStatus,
      FeedbackStatus? feedbackListStatus,
      FeedbackStatus? feedbackCategoryStatus,
      bool? isUpdatingFeedback,
      String? selectedCategory,
      String? failureMsg,
      String? username,
      List<String>? categories,
      List<FeedbackModel>? feedbacks}) {
    return FeedbackState(
      isAnonymous: isAnonymous ?? this.isAnonymous,
      isFeedbackCreate: isFeedbackCreate ?? this.isFeedbackCreate,
      username: username ?? this.username,
      failureMsg: failureMsg ?? this.failureMsg,
      isUpdatingFeedback: isUpdatingFeedback ?? this.isUpdatingFeedback,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      feedbackCategories: categories ?? feedbackCategories,
      feedbackModelList: feedbacks ?? feedbackModelList,
      paginationStatus: paginationStatus ?? this.paginationStatus,
      feedbackListStatus: feedbackListStatus ?? this.feedbackListStatus,
      feedbackCategoryStatus:
          feedbackCategoryStatus ?? this.feedbackCategoryStatus,
    );
  }
}

enum FeedbackStatus {
  feedbackInitial,
  feedbackLoading,
  feedbackSuccess,
  feedbackFailure
}
