import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:feedback_app/features/feedback/domain/usecases/create_new_feedback_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/feedback_repository_test.dart';

void main() {
  late FeedbackRepository feedbackRepository;
  late CreateNewFeedbackUseCase createNewFeedbackUseCase;
  FeedbackModel feedbackModel = FeedbackModel(id: "id");
  setUpAll(() {
    feedbackRepository = MockFeedbackRepository();
    createNewFeedbackUseCase = CreateNewFeedbackUseCase(feedbackRepository);
  });

  group('CreateNewFeedbackUseCase test', () {
    test('CreateNewFeedbackUseCase_success_isReturningTrue', () async {
      //arrange
      when(() => feedbackRepository.createNewFeedback(feedbackModel))
          .thenAnswer((realInvocation) async => const Right(true));

      //act
      final response = await createNewFeedbackUseCase.call(feedbackModel);

      //assert
      response.fold((l) => null, (r) => expect(r, true));
    });
    test('CreateNewFeedbackUseCase_failure_isReturningNull', () async {
      //arrange
      when(() => feedbackRepository.createNewFeedback(feedbackModel))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      //act
      final response = await createNewFeedbackUseCase.call(feedbackModel);

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
  });
}
