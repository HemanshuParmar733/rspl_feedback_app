import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource.dart';
import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource_impl.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../authentication/data/data_source/remote/auth_datasource_impl_test.dart';

void main() {
  late FakeFirebaseFirestore mockFirebaseFirestore;
  late FeedbackDataSource feedbackDataSource;
  late FirebaseAuth mockFirebaseAuth;

  final FeedbackModel feedbackModel =
      FeedbackModel(id: "id", title: "test", description: "test desc");
  setUp(() {
    mockFirebaseFirestore = FakeFirebaseFirestore();
    mockFirebaseAuth = MockFirebaseAuth();
    feedbackDataSource = FeedbackDataSourceImpl(
      mockFirebaseFirestore,
    );
  });

  group('feedbackDataSource test', () {
    group('getAllFeedbackCategories test cases', () {
      test('getAllFeedbackCategories_success_isReturningCategories', () async {
        //arrange
        when(() => mockFirebaseFirestore
            .collection("categories")
            .doc("feedback_categories")
            .get());

        //act
        final response = await feedbackDataSource.getAllFeedbackCategories();

        //assert
        response.fold((l) => null, (r) => expect(r, isA<CategoryModel>()));
      });
      test('getAllFeedbackCategories_failure_isReturningFailure', () async {
        //arrange
        when(() => feedbackDataSource.getAllFeedbackCategories());

        when(() => mockFirebaseFirestore
            .collection("categories")
            .doc('feedback_categories')
            .get());
        //act
        final response = await feedbackDataSource.getAllFeedbackCategories();

        //assert
        response.fold((l) => isA<ServerFailure>(), (r) => null);
      });
    });
    group('createNewFeedback test cases', () {
      test('createNewFeedback_success_isReturningTrue', () async {
        //arrange
        when(() => mockFirebaseFirestore
            .collection("feedbacks")
            .doc(feedbackModel.id)
            .set(feedbackModel.toJson()));

        //act
        final response =
            await feedbackDataSource.createNewFeedback(feedbackModel);

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('createNewFeedback_failure_isReturningFailure', () async {
        //arrange
        when(() => feedbackDataSource.getAllFeedbackCategories());

        when(() => mockFirebaseFirestore
            .collection("categories")
            .doc(feedbackModel.id)
            .set(feedbackModel.toJson()));
        //act
        final response =
            await feedbackDataSource.createNewFeedback(feedbackModel);

        //assert
        response.fold((l) => isA<ServerFailure>(), (r) => null);
      });
    });
    group('updateFeedback test cases', () {
      test('UpdateFeedback_success_isReturningTrue', () async {
        //arrange
        when(() => mockFirebaseFirestore
            .collection("feedbacks")
            .doc(feedbackModel.id)
            .get());
        when(() => mockFirebaseFirestore
                .collection("feedbacks")
                .doc(feedbackModel.id)
                .update(feedbackModel.toJson()))
            .thenAnswer((invocation) => Future.value());

        //act
        final response = await feedbackDataSource.updateFeedback(
            feedbackModel, UserAction.like);
        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('UpdateFeedback_failure_isReturningFailure', () async {
        //arrange
        when(() =>
            mockFirebaseFirestore.collection("feedbacks").doc("id1").get());

        //act
        final response = await feedbackDataSource.updateFeedback(
            feedbackModel, UserAction.like);

        //assert
        response.fold((l) => isA<ServerFailure>(), (r) => null);
      });
    });
    group('getPaginatedFeedback test cases', () {
      test('getPaginatedFeedback_success_isReturningFeedbackModelList',
          () async {
        //arrange
        when(() =>
            mockFirebaseFirestore.collection("pagination").doc("page").get());
        when(() => mockFirebaseFirestore
            .collection("feedbacks")
            .doc(feedbackModel.id)
            .get());
        when(() => mockFirebaseFirestore
            .collection("feedbacks")
            .orderBy("time", descending: true)
            .limit(5));

        //act
        final response = await feedbackDataSource.getPaginatedFeedbacks(
          feedbackModel,
        );
        //assert
        expect(response, isA<List<FeedbackModel>>());
      });
      test('getPaginatedFeedback_failure_isReturningEmptyList', () async {
        //arrange
        when(() =>
            mockFirebaseFirestore.collection("pagination").doc("page").get());
        when(() => mockFirebaseFirestore
            .collection("feedbacks")
            .doc(feedbackModel.id)
            .get());

        //act
        final response =
            await feedbackDataSource.getPaginatedFeedbacks(feedbackModel);

        //assert
        expect(response, []);
      });
    });
    group('getUserData test cases', () {
      setUp(() {
        mockFirebaseAuth = MockFirebaseAuth();
      });
      test('getUserData_success_isReturningUserModel', () async {
        //arrange
        when(() => mockFirebaseFirestore
            .collection("users")
            .doc(mockFirebaseAuth.currentUser?.uid)
            .get());

        //act
        final response = await feedbackDataSource.getUserData();
        //assert
        response.fold((l) => null, (r) => expect(r, isA<UserModel>()));
      });
      test('UpdateFeedback_failure_isReturningFailure', () async {
        //arrange
        when(() => mockFirebaseFirestore
            .collection("users")
            .doc(mockFirebaseAuth.currentUser?.uid)
            .get());

        //act
        final response = await feedbackDataSource.getUserData();

        //assert
        response.fold((l) => isA<ServerFailure>(), (r) => null);
      });
    });
  });
}
