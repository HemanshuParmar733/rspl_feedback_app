import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/failure/failures.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFeedbackDataSource extends Mock implements FeedbackDataSource {}

void main() {
  late FeedbackDataSource mockFeedbackDataSource;

  late FeedbackRepository feedbackRepository;

  setUp(() {
    mockFeedbackDataSource = MockFeedbackDataSource();
    feedbackRepository = FeedbackRepositoryImpl(mockFeedbackDataSource);
  });

  group('getAllFeedbackCategories Impl test', () {
    group('getAllFeedbackCategories test cases', () {
      test('getAllFeedbackCategories_success_isReturningCategoryModel',
          () async {
        //arrange
        when(() => mockFeedbackDataSource.getAllFeedbackCategories())
            .thenAnswer(
                (realInvocation) => Future.value(Right(CategoryModel())));
        //act
        final response = await feedbackRepository.getAllFeedbackCategories();

        //assert
        response.fold((l) => null, (r) => expect(r, isA<CategoryModel>()));
      });
      test('getAllFeedbackCategories_failure_isReturningFailureInstance',
          () async {
        //arrange
        when(() => mockFeedbackDataSource.getAllFeedbackCategories())
            .thenAnswer(
                (realInvocation) => Future.value(Left(ServerFailure())));
        //act
        final response = await feedbackRepository.getAllFeedbackCategories();

        //assert
        response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
      });
    });
    group('getUserData test cases', () {
      test('getUserData_success_isReturningUserDataModel', () async {
        //arrange
        when(() => feedbackRepository.getUserData())
            .thenAnswer((realInvocation) => Future.value(Right(UserModel())));
        //act
        final response = await feedbackRepository.getUserData();

        //assert
        response.fold((l) => null, (r) => expect(r, isA<UserModel>()));
      });
      test('getUserData_failure_isReturningFailureInstance', () async {
        //arrange
        when(() => mockFeedbackDataSource.getUserData()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));
        //act
        final response = await feedbackRepository.getUserData();

        //assert
        response.fold((l) => expect(l, isA<ServerFailure>()), (r) => null);
      });
    });

    group('getPaginatedFeedbacks test cases', () {
      test('getPaginatedFeedbacks_success_isReturningFeedbackModelList',
          () async {
        //arrange
        when(() => mockFeedbackDataSource
                .getPaginatedFeedbacks(FeedbackModel(id: "id")))
            .thenAnswer((realInvocation) async => [FeedbackModel(id: "id1")]);
        //act
        final response = await feedbackRepository
            .getPaginatedFeedbacks(FeedbackModel(id: "id"));

        //assert
        expect(response, isA<List<FeedbackModel>>());
      });
      test('getPaginatedFeedbacks_failure_isReturningEmptyList', () async {
        //arrange
        when(() => mockFeedbackDataSource.getPaginatedFeedbacks(
            FeedbackModel(id: "id"))).thenAnswer((realInvocation) async => []);
        //act
        final response = await feedbackRepository
            .getPaginatedFeedbacks(FeedbackModel(id: "id"));

        //assert
        expect(response, isA<List<FeedbackModel>>());
        assert(response.isEmpty);
      });
    });

    group('createNewFeedback test cases', () {
      test('createNewFeedback_success_isReturningTrue', () async {
        //arrange
        when(() => mockFeedbackDataSource
                .createNewFeedback(FeedbackModel(id: "id")))
            .thenAnswer((realInvocation) => Future.value(const Right(true)));
        //act
        final response =
            await feedbackRepository.createNewFeedback(FeedbackModel(id: "id"));

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('createNewFeedback_failure_isReturningFailureInstance', () async {
        //arrange
        when(() => mockFeedbackDataSource
                .createNewFeedback(FeedbackModel(id: "id")))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        //act
        final response =
            await feedbackRepository.createNewFeedback(FeedbackModel(id: "id"));

        //assert
        response.fold((l) => null, (r) => expect(r, isA<ServerFailure>()));
      });
    });

    group('updateFeedback test cases', () {
      test('updateFeedback_success_isReturningTrue', () async {
        //arrange
        when(() => mockFeedbackDataSource.updateFeedback(
                FeedbackModel(id: "id"), UserAction.like))
            .thenAnswer((realInvocation) => Future.value(const Right(true)));
        //act
        final response = await feedbackRepository.updateFeedback(
            FeedbackModel(id: "id"), UserAction.like);

        //assert
        response.fold((l) => null, (r) => expect(r, true));
      });
      test('createNewFeedback_failure_isReturningFailureInstance', () async {
        //arrange
        when(() => mockFeedbackDataSource.updateFeedback(
                FeedbackModel(id: "id"), UserAction.like))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        //act
        final response = await feedbackRepository.updateFeedback(
            FeedbackModel(id: "id"), UserAction.like);

        //assert
        response.fold((l) => null, (r) => expect(r, isA<ServerFailure>()));
      });
    });
  });
}
