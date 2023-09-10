import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failure/failures.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
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
