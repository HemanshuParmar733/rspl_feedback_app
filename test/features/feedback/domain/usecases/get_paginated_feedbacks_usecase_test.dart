import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_paginated_feedbacks_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/feedback_repository_test.dart';

void main() {
  late FeedbackRepository feedbackRepository;
  late GetPaginatedFeedbacksUseCase getPaginatedFeedbacksUseCase;
  FeedbackModel feedbackModel = FeedbackModel(id: "id");
  setUpAll(() {
    feedbackRepository = MockFeedbackRepository();
    getPaginatedFeedbacksUseCase =
        GetPaginatedFeedbacksUseCase(feedbackRepository);
  });

  group('GetPaginatedFeedbacksUseCase test', () {
    test('GetPaginatedFeedbacksUseCase_success_isReturningFeedbackModelList',
        () async {
      //arrange
      when(() => feedbackRepository.getPaginatedFeedbacks(feedbackModel))
          .thenAnswer((realInvocation) async =>
              [FeedbackModel(id: "id1"), FeedbackModel(id: "id2")]);

      //act
      final response = await getPaginatedFeedbacksUseCase.call(feedbackModel);

      //assert
      expect(response, isA<List<FeedbackModel>>());
      expect(response.first.id, "id1");
    });
    test('GetPaginatedFeedbacksUseCase_failure_isReturningEmptyList', () async {
      //arrange
      when(() => feedbackRepository.getPaginatedFeedbacks(feedbackModel))
          .thenAnswer((realInvocation) async => []);

      //act
      final response = await getPaginatedFeedbacksUseCase.call(feedbackModel);

      //assert
      expect(response, isA<List>());
      assert(response.isEmpty);
    });
  });
}
