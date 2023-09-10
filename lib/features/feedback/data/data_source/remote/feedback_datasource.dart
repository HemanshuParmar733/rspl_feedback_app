import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/enums/user_action_enum.dart';
import '../../../../../core/failure/failures.dart';
import '../../../../authentication/data/models/user_model.dart';
import '../../models/category_model.dart';
import '../../models/feedback_model.dart';

abstract class FeedbackDataSource {
  Future<Either<Failure, CategoryModel>> getAllFeedbackCategories();

  Future<Either<Failure, bool>> createNewFeedback(FeedbackModel model);

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllFeedbacksStream();

  Future<Either<Failure, bool>> updateFeedback(
      FeedbackModel model, UserAction userAction);

  Future<Either<Failure, UserModel>> getUserData();
}
