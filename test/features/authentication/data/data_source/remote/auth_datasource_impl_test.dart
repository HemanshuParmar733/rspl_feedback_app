import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource_impl.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../repositories/auth_repository_impl_test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUserCredentials extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;

  late MockFirebaseFirestore mockFirebaseFirestore;
  late AuthDataSource authDataSource;
  const String email = 'abc@gmail.com';
  const String password = '123456';

  final userModel =
      UserModel(email: 'abc@gmail.com', username: 'abc', uid: 'xyz');
  setUpAll(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    authDataSource = AuthDataSourceImpl(
      mockFirebaseAuth,
      mockFirebaseFirestore,
    );
  });

  group('authDataSource test', () {
    group('registerUser test cases', () {
      test('registerUser_success_isReturningTrue', () async {
        //arrange
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer(
          (_) async => MockUserCredentials(),
        );
        when(() => mockFirebaseFirestore
            .collection("users")
            .doc('xyz')
            .set(userModel.toJson())).thenAnswer((_) => Future.value());
        //act
        final response = await authDataSource.registerNewUser(
          email: "abc@gmail.com",
          password: "123456",
          userModel: userModel,
        );

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('registerUser_failure_isReturningFailure', () async {
        //arrange
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer(
          (_) async => MockUserCredentials(),
        );

        when(() => mockFirebaseFirestore
            .collection("users")
            .doc('xyz')
            .set(userModel.toJson())).thenAnswer((_) async => ServerFailure());
        //act
        final response = await authDataSource.registerNewUser(
          email: "abc@gmail.com",
          password: "123456",
          userModel: userModel,
        );

        //assert
        response.fold((l) => isA<ServerFailure>(), (r) => null);
      });
    });
    group('loginWithEmailPassword test cases', () {
      test('loginWithEmailPassword_success_isReturningTrue', () async {
        //arrange
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer(
          (_) async => MockUserCredentials(),
        );

        //act
        final response = await authDataSource.loginWithEmailPassword(
            "abc@gmail.com", "123456");

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('loginWithEmailPassword_failure_isReturningFailure', () async {
        //arrange
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => throw ServerFailure());

        //act
        final response = await authDataSource.loginWithEmailPassword(
          email,
          password,
        );

        //assert
        response.fold((l) => isA<ServerFailure>(), (r) => null);
      });
    });
    group('getCurrentUser test cases', () {
      test('getCurrentUser_success_isReturningUserInstance', () async {
        //arrange
        when(
          () => mockFirebaseAuth.currentUser,
        ).thenAnswer(
          (_) => MockUser(),
        );

        //act
        final response = authDataSource.getCurrentUser();

        //assert
        expect(response, isA<User>());
      });
      test('getCurrentUser_failure_isReturningNull', () async {
        //arrange
        when(
          () => mockFirebaseAuth.currentUser,
        ).thenAnswer((_) => null);

        //act
        final response = authDataSource.getCurrentUser();

        //assert
        expect(response, null);
      });
    });

    group('signOut test cases', () {
      test('signOut_success_isCalled', () async {
        //arrange
        when(
          () => mockFirebaseAuth.currentUser,
        ).thenAnswer(
          (_) => MockUser(),
        );
        when(
          () => mockFirebaseAuth.signOut(),
        ).thenAnswer(
          (_) async {},
        );

        //act
        await authDataSource.signOut();

        //assert
        mockFirebaseAuth.signOut().then((value) {});
      });
      test('signOut_failure_isCalled', () async {
        //arrange
        when(
          () => mockFirebaseAuth.currentUser,
        ).thenAnswer((_) => MockUser());

        //act
        await authDataSource.signOut();

        //assert
        mockFirebaseAuth.signOut().then((value) => {});
      });
    });
  });
}
