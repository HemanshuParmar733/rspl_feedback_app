import 'package:dartz/dartz.dart';

import '../../../../core/enums/user_action_enum.dart';
import '../../../../core/failure/failures.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, CategoryModel>> getAllFeedbackCategories();

  Future<Either<Failure, bool>> createNewFeedback(FeedbackModel model);

  Future<List<FeedbackModel>> getPaginatedFeedbacks(
      FeedbackModel? feedbackModel);

  Future<Either<Failure, bool>> updateFeedback(
      FeedbackModel model, UserAction userAction);

  Future<Either<Failure, UserModel>> getUserData();
}
