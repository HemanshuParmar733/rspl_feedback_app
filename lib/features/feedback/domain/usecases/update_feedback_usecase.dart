import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';

import '../../../../core/failure/failures.dart';
import '../repositories/feedback_repository.dart';

class UpdateFeedbackUseCase {
  final FeedbackRepository feedbackRepository;

  UpdateFeedbackUseCase(this.feedbackRepository);

  Future<Either<Failure, bool>> call(
      FeedbackModel feedbackModel, UserAction userAction) {
    return feedbackRepository.updateFeedback(feedbackModel, userAction);
  }
}
