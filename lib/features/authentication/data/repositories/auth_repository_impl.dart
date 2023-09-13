import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  User? getCurrentUser() {
   return _authDataSource.getCurrentUser();
  }

  @override
  Future<Either<Failure, bool>> loginWithEmailPassword(
      String email, String password) {
    return _authDataSource.loginWithEmailPassword(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerNewUser(
      {required String email,
      required String password,
      required UserModel userModel}) {
    return _authDataSource.registerNewUser(
        email: email, password: password, userModel: userModel);
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }
}
