import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/usecases/create_new_feedback_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_all_feedback_categories.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_paginated_feedbacks_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_userdata_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/update_feedback_usecase.dart';
import 'package:feedback_app/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllFeedbackCategoriesUseCase extends Mock
    implements GetAllFeedbackCategoriesUseCase {}

class MockCreateNewFeedbackUseCase extends Mock
    implements CreateNewFeedbackUseCase {}

class MockGetPaginatedFeedbacksUseCase extends Mock
    implements GetPaginatedFeedbacksUseCase {}

class MockUpdateFeedbackUseCase extends Mock implements UpdateFeedbackUseCase {}

class MockGetUserDataUseCase extends Mock implements GetUserDataUseCase {}

void main() {
  late FeedbackBloc feedbackBloc;
  late GetAllFeedbackCategoriesUseCase getAllFeedbackCategoriesUseCase;
  late CreateNewFeedbackUseCase createNewFeedbackUseCase;
  late GetPaginatedFeedbacksUseCase getPaginatedFeedbacksUseCase;
  late UpdateFeedbackUseCase updateFeedbackUseCase;
  late GetUserDataUseCase getUserDataUseCase;
  final feedbackModel = FeedbackModel(id: "id");
  final userModel =
      UserModel(uid: "1", username: "user", email: "abc@gmail.com");
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseCoreMocks();

    getAllFeedbackCategoriesUseCase = MockGetAllFeedbackCategoriesUseCase();
    createNewFeedbackUseCase = MockCreateNewFeedbackUseCase();
    getPaginatedFeedbacksUseCase = MockGetPaginatedFeedbacksUseCase();
    updateFeedbackUseCase = MockUpdateFeedbackUseCase();
    getUserDataUseCase = MockGetUserDataUseCase();

    feedbackBloc = FeedbackBloc(
        createNewFeedbackUseCase: createNewFeedbackUseCase,
        getAllFeedbacksUseCase: getPaginatedFeedbacksUseCase,
        getAllFeedbackCategoriesUseCase: getAllFeedbackCategoriesUseCase,
        updateFeedbackUseCase: updateFeedbackUseCase,
        getUserDataUseCase: getUserDataUseCase);
  });

  group('Feedback Bloc test', () {
    blocTest<FeedbackBloc, FeedbackState>(
        "OnCreateNewFeedbackEvent_success_isReturningBoolean",
        build: () {
          when(() => createNewFeedbackUseCase.call(feedbackModel))
              .thenAnswer((_) async => const Right(true));
          return feedbackBloc;
        },
        act: (bloc) =>
            bloc.add(OnCreateNewFeedbackEvent(feedbackModel: feedbackModel)),
        expect: () => [isA<FeedbackState>()],
        verify: (bloc) {
          verify(() => bloc.createNewFeedbackUseCase.call(feedbackModel))
              .called(1);
          expectLater(bloc.state.isFeedbackCreate, true);
        });
  });
  blocTest<FeedbackBloc, FeedbackState>(
      "OnUpdateFeedbackEvent_success_isReturningBoolean",
      build: () {
        when(() => updateFeedbackUseCase.call(feedbackModel, UserAction.like))
            .thenAnswer((_) async => const Right(true));

        return feedbackBloc;
      },
      act: (bloc) => bloc.add(OnUpdateFeedbackEvent(
          feedbackModel: feedbackModel, userAction: UserAction.like)),
      expect: () => [isA<FeedbackState>()],
      wait: const Duration(seconds: 2),
      verify: (bloc) {
        verify(() =>
                bloc.updateFeedbackUseCase.call(feedbackModel, UserAction.like))
            .called(1);
        expectLater(bloc.state.isUpdatingFeedback, true);
      });
  blocTest<FeedbackBloc, FeedbackState>(
      "OnGetAllFeedbackCategoryEvent_success_isReturningCategoryList",
      build: () {
        when(() => getAllFeedbackCategoriesUseCase.call()).thenAnswer(
            (_) async =>
                Right(CategoryModel(listOfCategories: ["Network", "Other"])));
        return feedbackBloc;
      },
      act: (bloc) => bloc.add(const OnGetAllFeedbackCategoryEvent()),
      expect: () => [isA<FeedbackState>()],
      wait: const Duration(seconds: 2),
      verify: (bloc) {
        verify(() => bloc.getAllFeedbackCategoriesUseCase.call()).called(1);
        expectLater(bloc.state.feedbackCategories, isA<List<String>>());
        assert(bloc.state.feedbackCategories!.contains("Network"));
        assert(bloc.state.feedbackCategories!.contains("Other"));
        expect(bloc.state.feedbackCategories!.length, 2);
      });

  blocTest<FeedbackBloc, FeedbackState>(
      "OnGetLatestFeedbackEvent_success_isReturningFeedbackModelList",
      build: () {
        when(
          () => getPaginatedFeedbacksUseCase.call(null),
        ).thenAnswer((_) async => [FeedbackModel(id: "id")]);
        return feedbackBloc;
      },
      act: (bloc) => bloc.add(const OnGetLatestFeedbackEvent()),
      expect: () => [isA<FeedbackState>()],
      verify: (bloc) {
        verify(() => bloc.getAllFeedbacksUseCase.call(null)).called(1);
        expectLater(bloc.state.feedbackModelList, isA<List<FeedbackModel>>());
        expectLater(bloc.state.feedbackModelList?.length, 1);
        expectLater(bloc.state.feedbackModelList?.first.id, "id");
      });

  blocTest<FeedbackBloc, FeedbackState>(
      "OnPaginationNextPageEvent_success_isReturningPaginationSuccess",
      build: () {
        when(
          () => getPaginatedFeedbacksUseCase.call(feedbackModel),
        ).thenAnswer((_) => Future.value([feedbackModel]));
        return feedbackBloc;
      },
      seed: () => FeedbackState(feedbackModelList: [feedbackModel]),
      act: (bloc) => bloc.add(OnPaginationNextPageEvent()),
      expect: () => [isA<FeedbackState>()],
      verify: (bloc) {
        verify(() => bloc.getAllFeedbacksUseCase.call(feedbackModel)).called(1);
        expectLater(bloc.state.feedbackModelList, isA<List<FeedbackModel>>());
        expectLater(bloc.state.feedbackModelList?.length, 1);
        expectLater(bloc.state.feedbackModelList?.first.id, "id");
      });

  blocTest<FeedbackBloc, FeedbackState>(
      "OnGetUserDataEvent_success_isReturningUserModel",
      build: () {
        when(
          () => getUserDataUseCase.call(),
        ).thenAnswer((_) async => Right(userModel));
        return feedbackBloc;
      },
      wait: const Duration(seconds: 2),
      act: (bloc) => bloc.add(OnGetUserDataEvent()),
      expect: () => [isA<FeedbackState>()],
      verify: (bloc) {
        verify(() => bloc.getUserDataUseCase.call()).called(1);
        expect(bloc.state.username, "user");
      });
  blocTest<FeedbackBloc, FeedbackState>(
      "OnCategoryChangeEvent_success_isChangingCategory",
      build: () {
        return feedbackBloc;
      },
      seed: () => const FeedbackState(
          feedbackCategories: ["Network", "Other"], selectedCategory: "Other"),
      act: (bloc) => bloc.add(const OnCategoryChangeEvent(category: "Network")),
      expect: () => [isA<FeedbackState>()],
      verify: (bloc) {
        expect(bloc.state.selectedCategory, "Network");
      });
  blocTest<FeedbackBloc, FeedbackState>(
      "OnAnonymousChangeEvent_success_isChangingAnonymous",
      build: () {
        return feedbackBloc;
      },
      seed: () => const FeedbackState(isAnonymous: true),
      act: (bloc) => bloc.add(const OnAnonymousChangeEvent(isAnonymous: false)),
      expect: () => [isA<FeedbackState>()],
      verify: (bloc) {
        expect(bloc.state.isAnonymous, false);
      });
}
