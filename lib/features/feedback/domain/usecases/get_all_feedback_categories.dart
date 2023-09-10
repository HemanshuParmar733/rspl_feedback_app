import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';

import '../repositories/feedback_repository.dart';

class GetAllFeedbackCategoriesUseCase {
  final FeedbackRepository feedbackRepository;

  GetAllFeedbackCategoriesUseCase(this.feedbackRepository);

  Future<Either<Failure, CategoryModel>> call() {
    return feedbackRepository.getAllFeedbackCategories();
  }
}
