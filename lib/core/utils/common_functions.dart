import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';

import '../enums/user_action_enum.dart';

FeedbackModel performLikeDislikeLogic(
    {required UserAction userAction,
    required String userId,
    required FeedbackModel feedbackModel}) {
  FeedbackModel currentFeedback = feedbackModel;
  if (userAction == UserAction.like) {
    if (!currentFeedback.likes!.contains(userId)) {
      if (currentFeedback.dislikes!.contains(userId)) {
        // if already feedback disliked then remove dislike and add like
        currentFeedback.dislikes!.remove(userId);
        currentFeedback.likes!.add(userId);
      } else {
        currentFeedback.likes!.add(userId);
      }
    }

    // remove like if already given
    else {
      currentFeedback.likes!.remove(userId);
    }
  } else {
    // same logic for dislike button
    if (!currentFeedback.dislikes!.contains(userId)) {
      if (currentFeedback.likes!.contains(userId)) {
        // if already feedback liked then remove dislike and add dislike
        currentFeedback.likes!.remove(userId);
        currentFeedback.dislikes!.add(userId);
      }
      // if feedback dislike not given simply add dislike
      if (!currentFeedback.dislikes!.contains(userId)) {
        currentFeedback.dislikes!.add(userId);
      }
    } else {
      currentFeedback.dislikes!.remove(userId);
    }
  }
  return currentFeedback;
}
