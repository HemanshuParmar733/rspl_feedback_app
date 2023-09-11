import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';

class GetPaginatedFeedbacksUseCase {
  final FeedbackRepository feedbackRepository;

  GetPaginatedFeedbacksUseCase(this.feedbackRepository);

  Future<List<FeedbackModel>> call(FeedbackModel? feedbackModel) {
    return feedbackRepository.getPaginatedFeedbacks(feedbackModel);
  }
}
