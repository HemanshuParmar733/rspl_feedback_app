import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';

class GetAllFeedbacksUseCase {
  final FeedbackRepository feedbackRepository;

  GetAllFeedbacksUseCase(this.feedbackRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> call() {
    return feedbackRepository.getAllFeedbacksStream();
  }
}
