import 'package:dartz/dartz.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/failure/failures.dart';

abstract class AuthDataSource {
  Future<Either<Failure, bool>> registerNewUser(
      {required String email,
      required String password,
      required UserModel userModel});

  Future<Either<Failure, bool>> loginWithEmailPassword(
    String email,
    String password,
  );

  User? getCurrentUser();

  Future<void> signOut();
}
