import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:feedback_app/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/auth_repository_test.dart';

void main() {
  late AuthRepository authRepository;
  late SignOutUseCase signOutUseCase;

  setUpAll(() {
    authRepository = MockAuthRepository();
    signOutUseCase = SignOutUseCase(authRepository);
  });

  group('SignOutUseCase test', () {
    test('SignOutUseCase_success_isCalledOnce', () async {
      //arrange
      when(() => authRepository.signOut())
          .thenAnswer((realInvocation) => Future.value());

      //act
      await signOutUseCase.call();

      //assert
      verify(() => authRepository.signOut()).called(1);
    });
    test('SignOutUseCase_failure_isThrowingFailureInstance', () async {
      //arrange
      when(() => authRepository.signOut())
          .thenAnswer((realInvocation) => throw (ServerFailure()));

      //act
      try {
        await signOutUseCase.call();
      } catch (e) {
        expect(e, isA<ServerFailure>());
      }
    });
  });
}
