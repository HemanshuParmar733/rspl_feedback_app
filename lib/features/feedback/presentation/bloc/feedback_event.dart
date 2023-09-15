part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAllFeedbackCategoryEvent extends FeedbackEvent {
  final String? firstDocId;

  const OnGetAllFeedbackCategoryEvent({this.firstDocId});
}

class OnCategoryChangeEvent extends FeedbackEvent {
  final String category;

  const OnCategoryChangeEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class OnAnonymousChangeEvent extends FeedbackEvent {
  final bool isAnonymous;

  const OnAnonymousChangeEvent({required this.isAnonymous});

  @override
  List<Object?> get props => [isAnonymous];
}

class OnGetUserDataEvent extends FeedbackEvent {}

class OnCreateNewFeedbackEvent extends FeedbackEvent {
  final FeedbackModel feedbackModel;

  const OnCreateNewFeedbackEvent({required this.feedbackModel});

  @override
  List<Object?> get props => [feedbackModel.id];
}

class OnUpdateFeedbackEvent extends FeedbackEvent {
  final FeedbackModel feedbackModel;
  final UserAction userAction;

  const OnUpdateFeedbackEvent({
    required this.feedbackModel,
    required this.userAction,
  });

  @override
  List<Object?> get props => [feedbackModel.id, userAction];
}

class OnGetLatestFeedbackEvent extends FeedbackEvent {
  final FeedbackModel? feedbackModel;

  const OnGetLatestFeedbackEvent({this.feedbackModel});

  @override
  List<Object?> get props => [feedbackModel?.id];
}

class OnPaginationNextPageEvent extends FeedbackEvent {}
