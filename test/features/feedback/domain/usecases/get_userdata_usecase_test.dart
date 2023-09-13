import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_userdata_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/feedback_repository_test.dart';

void main() {
  late FeedbackRepository feedbackRepository;
  late GetUserDataUseCase getUserDataUseCase;
  setUpAll(() {
    feedbackRepository = MockFeedbackRepository();
    getUserDataUseCase = GetUserDataUseCase(feedbackRepository);
  });

  group('GetUserDataUseCase test', () {
    test('GetUserDataUseCase_success_isReturningUserModel', () async {
      //arrange
      when(() => feedbackRepository.getUserData())
          .thenAnswer((realInvocation) async => Right(UserModel()));

      //act
      final response = await getUserDataUseCase.call();

      //assert
      response.fold((l) => null, (r) {
        expect(r, isA<UserModel>());
      });
    });
    test('GetUserDataUseCase_failure_isReturningFailureInstance', () async {
      //arrange
      when(() => feedbackRepository.getUserData())
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      //act
      final response = await getUserDataUseCase.call();

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
  });
}
