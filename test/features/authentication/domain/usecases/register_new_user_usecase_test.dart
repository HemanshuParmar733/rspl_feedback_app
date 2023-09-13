import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:feedback_app/features/authentication/domain/usecases/register_new_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/auth_repository_test.dart';

void main() {
  late AuthRepository authRepository;
  late RegisterNewUserUseCase registerNewUserUseCase;
  const String email = 'abc@gmail.com';
  const String password = '123456';
  final userModel = UserModel(email: email, username: 'abc', uid: 'xyz');

  setUpAll(() {
    authRepository = MockAuthRepository();
    registerNewUserUseCase = RegisterNewUserUseCase(authRepository);
  });

  group('RegisterNewUserUseCase test', () {
    test('RegisterNewUserUseCase_success_isReturningTrue', () async {
      //arrange
      when(() => authRepository.registerNewUser(
              email: email, password: password, userModel: userModel))
          .thenAnswer((realInvocation) => Future.value(const Right(true)));

      //act
      final response = await registerNewUserUseCase.call(
          email: email, password: password, userModel: userModel);

      //assert
      response.fold((l) => null, (r) => expect(r, true));
    });
    test('RegisterNewUserUseCase_failure_isReturningFailureInstance', () async {
      //arrange
      when(() => authRepository.registerNewUser(
              email: email, password: password, userModel: userModel))
          .thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));

      //act
      final response = await registerNewUserUseCase.call(
          email: email, password: password, userModel: userModel);

      //assert
      response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
    });
  });
}
