import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/failure/failures.dart';

class FeedbackDataSourceImpl implements FeedbackDataSource {
  final FirebaseFirestore _firestore;

  FeedbackDataSourceImpl(this._firestore);

  @override
  Future<Either<Failure, CategoryModel>> getAllFeedbackCategories() async {
    try {
      final snapshot = await _firestore
          .collection("categories")
          .doc("feedback_categories")
          .get();
      return Right(CategoryModel.fromJson(snapshot.data()!));
    } catch (e) {
      return Left(
          ServerFailure(error: "Failure : failed to get feedback categories."));
    }
  }

  @override
  Future<Either<Failure, bool>> createNewFeedback(FeedbackModel model) async {
    try {
      await _firestore
          .collection("feedbacks")
          .doc(model.id)
          .set(model.toJson());
      return const Right(true);
    } catch (e) {
      return Left(
          ServerFailure(error: "Failure : failed to create new feedback."));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final result = await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.data() != null) {
        return Right(UserModel.fromJson(result.data()!));
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      return Left(
          ServerFailure(error: "Failure : failed to create new feedback."));
    }
  }

  @override
  Future<Either<Failure, bool>> updateFeedback(FeedbackModel model,
      UserAction userAction) async {
    try {
      final result =
      await _firestore.collection("feedbacks").doc(model.id).get();

      FeedbackModel currentFeedback = FeedbackModel.fromJson(result.data());
      // get current userId
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // user can have only one like/dislike at a time logic
      if (userAction == UserAction.like) {
        if (!currentFeedback.likes!.contains(userId) &&
            !currentFeedback.dislikes!.contains(userId)) {
          currentFeedback.likes!.add(userId);
        } else {
          currentFeedback.likes!.remove(userId);
        }
      }
      if (userAction == UserAction.dislike &&
          !currentFeedback.likes!.contains(userId)) {
        if (!currentFeedback.dislikes!.contains(userId)) {
          currentFeedback.dislikes!.add(userId);
        } else {
          currentFeedback.dislikes!.remove(userId);
        }
      }
      await _firestore
          .collection("feedbacks")
          .doc(model.id)
          .update(currentFeedback.toJson());
      return const Right(true);
    } catch (e) {
      return Left(
          ServerFailure(error: "Failure : failed to create new feedback."));
    }
  }

  Future<int> getPageSize() async {
    try {
      final paginationDoc = await _firestore
          .collection("pagination")
          .doc("page").get();
      if (paginationDoc.exists) {
        return int.parse(paginationDoc.get('page_size'));
      }
    } catch (e) {
      debugPrint('Exception while fetching pageSize : ${e.toString()}');
    }
    return 0;
  }
  @override
  Future<List<FeedbackModel>> getPaginatedFeedbacks(
      FeedbackModel? feedbackModel) async {
    try {
      final int pageSize = await getPageSize();
      if (feedbackModel != null) {
        // get document from firestore
        final lastDoc = await _firestore
            .collection("feedbacks")
            .doc(feedbackModel.id)
            .get();
        if (lastDoc.exists) {
          // going forward in pagination
          final query = _firestore
              .collection("feedbacks")
              .orderBy("time", descending: true)
              .startAfterDocument(lastDoc)
              .limit(pageSize);
          final snapshots = await query.get();
          return snapshots.docs.map((e) => FeedbackModel.fromJson(e)).toList();
        }
      } else {
        // initial 5 items sorted list at time of page load
        final query = _firestore
            .collection("feedbacks")
            .orderBy("time", descending: true)
            .limit(pageSize);
        final snapshots = await query.get();
        return snapshots.docs.map((e) => FeedbackModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint('Exception getting paginated feedback : ${e.toString()}');
    }
    return [];
  }
}


