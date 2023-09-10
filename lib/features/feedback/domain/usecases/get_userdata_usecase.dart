import 'package:dartz/dartz.dart';

import '../../../../core/failure/failures.dart';
import '../../../authentication/data/models/user_model.dart';
import '../repositories/feedback_repository.dart';

class GetUserDataUseCase {
  final FeedbackRepository feedbackRepository;

  GetUserDataUseCase(this.feedbackRepository);

  Future<Either<Failure, UserModel>> call() {
    return feedbackRepository.getUserData();
  }
}
