import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_all_feedback_categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/feedback_repository_test.dart';

void main() {
  late FeedbackRepository feedbackRepository;
  late GetAllFeedbackCategoriesUseCase getAllFeedbackCategoriesUseCase;
  setUpAll(() {
    feedbackRepository = MockFeedbackRepository();
    getAllFeedbackCategoriesUseCase =
        GetAllFeedbackCategoriesUseCase(feedbackRepository);
  });

  group('GetAllFeedbackCategoriesUseCase test', () {
    test('GetAllFeedbackCategoriesUseCase_success_isReturningCategoryModel',
        () async {
      //arrange
      when(() => feedbackRepository.getAllFeedbackCategories()).thenAnswer(
          (realInvocation) async =>
              Right(CategoryModel(listOfCategories: ["category1"])));

      //act
      final response = await getAllFeedbackCategoriesUseCase.call();

      //assert
      response.fold((l) => null, (r) {
        expect(r, isA<CategoryModel>());
        assert(r.listOfCategories!.contains("category1"));
      });
    });
    test('GetAllFeedbackCategoriesUseCase_failure_isReturningNull', () async {
      //arrange
      when(() => feedbackRepository.getAllFeedbackCategories())
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      //act
      final response = await getAllFeedbackCategoriesUseCase.call();

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
  });
}
