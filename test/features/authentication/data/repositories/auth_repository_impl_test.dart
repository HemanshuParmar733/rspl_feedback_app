import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockUser extends Mock implements User {}

void main() {
  late AuthDataSource mockAuthDataSource;

  late AuthRepositoryImpl authRepositoryImpl;
  const String email = 'abc@gmail.com';
  const String password = '123456';
  final userModel = UserModel(email: email, username: 'abc', uid: 'xyz');
  setUpAll(() {
    mockAuthDataSource = MockAuthDataSource();
    authRepositoryImpl = AuthRepositoryImpl(mockAuthDataSource);
  });

  group('AuthRepository Impl test', () {
    group('registerUser test cases', () {
      test('registerUser_success_isReturningTrue', () async {
        //arrange
        when(() => mockAuthDataSource.registerNewUser(
                email: email, password: password, userModel: userModel))
            .thenAnswer((realInvocation) => Future.value(Right(true)));
        //act
        final response = await authRepositoryImpl.registerNewUser(
            email: email, password: password, userModel: userModel);

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('registerUser_failure_isReturningFailureInstance', () async {
        //arrange
        when(() => mockAuthDataSource.registerNewUser(
                email: email, password: password, userModel: userModel))
            .thenAnswer(
                (realInvocation) => Future.value(Left(ServerFailure())));
        //act
        final response = await authRepositoryImpl.registerNewUser(
            email: email, password: password, userModel: userModel);

        //assert
        response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
      });
    });
    group('loginWithEmailPassword test cases', () {
      test('loginWithEmailPassword_success_isReturningTrue', () async {
        //arrange
        when(() => mockAuthDataSource.loginWithEmailPassword(email, password))
            .thenAnswer((realInvocation) => Future.value(const Right(true)));
        //act
        final response =
            await authRepositoryImpl.loginWithEmailPassword(email, password);

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('loginWithEmailPassword_failure_isReturningFailureInstance',
          () async {
        //arrange
        when(() => mockAuthDataSource.loginWithEmailPassword(email, password))
            .thenAnswer(
                (realInvocation) => Future.value(Left(ServerFailure())));
        //act
        final response =
            await authRepositoryImpl.loginWithEmailPassword(email, password);

        //assert
        response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
      });
    });

    group('getCurrentUser test cases', () {
      test('getCurrentUser_success_isReturningUserInstance', () async {
        //arrange
        when(() => mockAuthDataSource.getCurrentUser())
            .thenAnswer((realInvocation) => MockUser());
        //act
        final response = authRepositoryImpl.getCurrentUser();

        //assert
        expect(response, isA<User>());
      });
      test('getCurrentUser_failure_isReturningNull', () async {
        //arrange
        when(() => mockAuthDataSource.getCurrentUser())
            .thenAnswer((realInvocation) => null);
        //act
        final response = authRepositoryImpl.getCurrentUser();

        //assert
        expect(response, null);
      });
    });

    group('signOut test cases', () {
      test('signOut_success_isCalledOnce', () async {
        //arrange
        when(() => mockAuthDataSource.signOut())
            .thenAnswer((realInvocation) => Future.value());
        //act
        await authRepositoryImpl.signOut();

        //assert
        verify(() => mockAuthDataSource.signOut()).called(1);
      });
      test('signOut_failure_isReturningFailureInstance', () async {
        //arrange
        when(() => mockAuthDataSource.signOut())
            .thenAnswer((realInvocation) => throw (ServerFailure()));
        //act
        try {
          await authRepositoryImpl.signOut();
        } catch (e) {
          //assert
          expect(e, isA<ServerFailure>());
        }
      });
    });
  });
}
