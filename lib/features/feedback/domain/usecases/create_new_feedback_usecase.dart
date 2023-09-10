import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';

class CreateNewFeedbackUseCase {
  final FeedbackRepository feedbackRepository;

  CreateNewFeedbackUseCase(this.feedbackRepository);

  Future<Either<Failure, bool>> call(FeedbackModel feedbackModel) {
    return feedbackRepository.createNewFeedback(feedbackModel);
  }
}
