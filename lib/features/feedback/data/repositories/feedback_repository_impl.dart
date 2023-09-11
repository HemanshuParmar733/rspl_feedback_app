import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackDataSource _feedbackDataSource;

  FeedbackRepositoryImpl(this._feedbackDataSource);

  @override
  Future<Either<Failure, bool>> createNewFeedback(FeedbackModel model) {
    return _feedbackDataSource.createNewFeedback(model);
  }

  @override
  Future<Either<Failure, CategoryModel>> getAllFeedbackCategories() {
    return _feedbackDataSource.getAllFeedbackCategories();
  }

  @override
  Future<List<FeedbackModel>> getPaginatedFeedbacks(
      FeedbackModel? feedbackModel) {
    return _feedbackDataSource.getPaginatedFeedbacks(feedbackModel);
  }

  @override
  Future<Either<Failure, bool>> updateFeedback(
      FeedbackModel model, UserAction userAction) {
    return _feedbackDataSource.updateFeedback(model, userAction);
  }

  @override
  Future<Either<Failure, UserModel>> getUserData() {
    return _feedbackDataSource.getUserData();
  }
}
