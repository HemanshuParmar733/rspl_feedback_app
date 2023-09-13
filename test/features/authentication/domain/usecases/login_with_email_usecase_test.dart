import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:feedback_app/features/authentication/domain/usecases/login_with_email_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/auth_repository_test.dart';

void main() {
  late AuthRepository authRepository;
  late LoginWithEmailUseCase loginWithEmailUseCase;
  const String email = 'abc@gmail.com';
  const String password = '123456';
  setUpAll(() {
    authRepository = MockAuthRepository();
    loginWithEmailUseCase = LoginWithEmailUseCase(authRepository);
  });

  group('LoginWithEmailUseCase test', () {
    test('LoginWithEmailUseCase_success_isReturningTrue', () async {
      //arrange
      when(() => authRepository.loginWithEmailPassword(email, password))
          .thenAnswer((realInvocation) => Future.value(const Right(true)));

      //act
      final response =
          await loginWithEmailUseCase.call(email: email, password: password);

      //assert
      response.fold((l) => null, (r) => expect(r, true));
    });
    test('LoginWithEmailUseCase_failure_isReturningFailureInstance', () async {
      //arrange
      when(() => authRepository.loginWithEmailPassword(email, password))
          .thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));

      //act
      final response =
          await loginWithEmailUseCase.call(email: email, password: password);

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
  });
}
