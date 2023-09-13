import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:feedback_app/features/feedback/domain/usecases/update_feedback_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/feedback_repository_test.dart';

void main() {
  late FeedbackRepository feedbackRepository;
  late UpdateFeedbackUseCase updateFeedbackUseCase;
  FeedbackModel feedbackModel = FeedbackModel(id: "id");
  setUpAll(() {
    feedbackRepository = MockFeedbackRepository();
    updateFeedbackUseCase = UpdateFeedbackUseCase(feedbackRepository);
  });

  group('UpdateFeedbackUseCase test', () {
    test('UpdateFeedbackUseCase_like_success_isReturningTrue', () async {
      //arrange
      when(() =>
              feedbackRepository.updateFeedback(feedbackModel, UserAction.like))
          .thenAnswer((realInvocation) async => const Right(true));

      //act
      final response =
          await updateFeedbackUseCase.call(feedbackModel, UserAction.like);

      //assert
      response.fold((l) => null, (r) => expect(r, true));
    });
    test('UpdateFeedbackUseCase_like_failure_isReturningFailureInstance',
        () async {
      //arrange
      when(() => feedbackRepository.createNewFeedback(feedbackModel))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      //act
      final response =
          await updateFeedbackUseCase.call(feedbackModel, UserAction.like);

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
    test('UpdateFeedbackUseCase_dislike_success_isReturningTrue', () async {
      //arrange
      when(() => feedbackRepository.updateFeedback(
              feedbackModel, UserAction.dislike))
          .thenAnswer((realInvocation) async => const Right(true));

      //act
      final response =
          await updateFeedbackUseCase.call(feedbackModel, UserAction.dislike);

      //assert
      response.fold((l) => null, (r) => expect(r, true));
    });
    test('UpdateFeedbackUseCase_dislike_failure_isReturningFailureInstance',
        () async {
      //arrange
      when(() => feedbackRepository.updateFeedback(
              feedbackModel, UserAction.dislike))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      //act
      final response =
          await updateFeedbackUseCase.call(feedbackModel, UserAction.dislike);

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
  });
}
