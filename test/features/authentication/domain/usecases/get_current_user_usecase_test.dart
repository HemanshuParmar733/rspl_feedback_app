import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:feedback_app/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/repositories/auth_repository_impl_test.dart';
import '../repositories/auth_repository_test.dart';

void main() {
  late AuthRepository authRepository;
  late GetCurrentUserUseCase getCurrentUserUseCase;

  final mockUser = MockUser();
  setUpAll(() {
    authRepository = MockAuthRepository();
    getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);
  });

  group('GetCurrentUserUseCase test', () {
    test('GetCurrentUserUseCase_success_isReturningUser', () async {
      //arrange
      when(() => authRepository.getCurrentUser())
          .thenAnswer((realInvocation) => mockUser);

      //act
      final response = getCurrentUserUseCase.call();

      //assert
      expect(response, isA<User>());
    });
    test('GetCurrentUserUseCase_failure_isReturningNull', () async {
      //arrange
      when(() => authRepository.getCurrentUser())
          .thenAnswer((realInvocation) => null);

      //act
      final response = getCurrentUserUseCase.call();

      //assert
      expect(response, null);
    });
  });
}
