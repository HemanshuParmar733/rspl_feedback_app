import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/failure/failures.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  AuthDataSourceImpl(this._firebaseAuth, this._fireStore);

  @override
  Future<Either<Failure, bool>> registerNewUser({
    required String email,
    required String password,
    required UserModel userModel,
  }) async {
    try {
      final loginCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (loginCredentials.user != null) {
        userModel.uid = loginCredentials.user!.uid;
        await _fireStore
            .collection("users")
            .doc(userModel.uid)
            .set(userModel.toJson());

        return const Right(true);
      }
    } catch (e) {
      return Left(AuthFailure(
          error: 'Exception in User registration : ${e.toString()}'));
    }
    return Left(AuthFailure(error: 'User registration failed.'));
  }

  @override
  Future<Either<Failure, bool>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return const Right(true);
      }
    } catch (e) {
      return Left(
          AuthFailure(error: 'Exception in User Login : ${e.toString()}'));
    }
    return Left(AuthFailure(error: 'User Login failed.'));
  }

  @override
  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      debugPrint('Exception in getUser : ${e.toString()}');
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    final user = getCurrentUser();
    if (user != null) {
      _firebaseAuth.signOut();
    }
  }
}
