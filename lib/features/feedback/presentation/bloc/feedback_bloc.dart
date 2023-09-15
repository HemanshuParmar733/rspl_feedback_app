import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/core/utils/common_functions.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_new_feedback_usecase.dart';
import '../../domain/usecases/get_all_feedback_categories.dart';
import '../../domain/usecases/get_paginated_feedbacks_usecase.dart';
import '../../domain/usecases/get_userdata_usecase.dart';
import '../../domain/usecases/update_feedback_usecase.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final CreateNewFeedbackUseCase createNewFeedbackUseCase;
  final GetPaginatedFeedbacksUseCase getAllFeedbacksUseCase;
  final GetAllFeedbackCategoriesUseCase getAllFeedbackCategoriesUseCase;
  final UpdateFeedbackUseCase updateFeedbackUseCase;

  final GetUserDataUseCase getUserDataUseCase;

  FeedbackBloc(
      {required this.createNewFeedbackUseCase,
      required this.getAllFeedbacksUseCase,
      required this.getAllFeedbackCategoriesUseCase,
      required this.updateFeedbackUseCase,
      required this.getUserDataUseCase})
      : super(const FeedbackState()) {
    on<OnCreateNewFeedbackEvent>(_onCreateNewFeedback);
    on<OnUpdateFeedbackEvent>(_onUpdateFeedback);
    on<OnGetLatestFeedbackEvent>(_onGetLatestFeedback);
    on<OnGetAllFeedbackCategoryEvent>(_onGetAllFeedbackCategories);
    on<OnPaginationNextPageEvent>(_onPaginationNextPage);
    on<OnGetUserDataEvent>(_onGetUserData);
    on<OnCategoryChangeEvent>(_onCategoryChange);
    on<OnAnonymousChangeEvent>(_onAnonymousChange);
  }

  Future<void> _onCreateNewFeedback(
    OnCreateNewFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    try {
      //fill user name
      event.feedbackModel.category = state.selectedCategory ?? "Network";
      event.feedbackModel.reporterName = (state.isAnonymous ?? false)
          ? "Anonymous"
          : event.feedbackModel.reporterName;

      event.feedbackModel.userName =
          state.username ?? "Unknown"; // create new feedback

      final response = await createNewFeedbackUseCase.call(event.feedbackModel);
      response.fold((l) {
        emit(state.copyWith(
            isFeedbackCreate: false,
            feedbackListStatus: FeedbackStatus.feedbackFailure,
            failureMsg: 'failed to create new feedback.'));
      }, (bool isCreated) {
        if (isCreated) {
          emit(state.copyWith(
              feedbackListStatus: FeedbackStatus.feedbackSuccess,
              isFeedbackCreate: true));
        } else {
          emit(state.copyWith(
              isFeedbackCreate: false,
              feedbackListStatus: FeedbackStatus.feedbackFailure,
              failureMsg: 'failed to create new feedback.'));
        }
      });
    } catch (e) {
      emit(state.copyWith(
          feedbackListStatus: FeedbackStatus.feedbackFailure,
          isFeedbackCreate: false,
          failureMsg:
              'Exception: failed to create new feedback : ${e.toString()}'));
    }
  }

  Future<void> _onUpdateFeedback(
    OnUpdateFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    final response = await updateFeedbackUseCase.call(
      event.feedbackModel,
      event.userAction,
    );
    response.fold((l) {
      emit(state.copyWith(
          feedbackListStatus: FeedbackStatus.feedbackFailure,
          failureMsg: 'failed to update feedback.'));
    }, (bool isUpdated) {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      performLikeDislikeLogic(
          userAction: event.userAction,
          userId: userId,
          feedbackModel: event.feedbackModel);

      if (isUpdated) {
        emit(state.copyWith(
          feedbacks: state.feedbackModelList,
          feedbackListStatus: FeedbackStatus.feedbackSuccess,
          isUpdatingFeedback: !state.isUpdatingFeedback,
        ));
      }
    });
  }

  Future<void> _onGetLatestFeedback(
      OnGetLatestFeedbackEvent event, Emitter<FeedbackState> emit) async {
    final List<FeedbackModel> feedbacks =
        await getAllFeedbacksUseCase.call(event.feedbackModel);
    emit(state.copyWith(
      feedbacks: feedbacks,
      feedbackListStatus: FeedbackStatus.feedbackSuccess,
    ));
  }

  Future<void> _onGetAllFeedbackCategories(
    OnGetAllFeedbackCategoryEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    final response = await getAllFeedbackCategoriesUseCase.call();
    response.fold((l) {
      emit(state.copyWith(
          feedbackCategoryStatus: FeedbackStatus.feedbackFailure,
          failureMsg: 'failed to get feedback categories.'));
    }, (categoryModel) {
      emit(state.copyWith(
          feedbackCategoryStatus: FeedbackStatus.feedbackSuccess,
          categories: categoryModel.listOfCategories ?? ["Other"],
          selectedCategory: categoryModel.listOfCategories?.first));
    });
  }

  Future<void> _onPaginationNextPage(
      OnPaginationNextPageEvent event, Emitter<FeedbackState> emit) async {
    emit(state.copyWith(paginationStatus: FeedbackStatus.feedbackLoading));

    final response =
        await getAllFeedbacksUseCase.call(state.feedbackModelList?.last);
    // append upcoming lis data into existing list
    state.feedbackModelList?.addAll(response);

    emit(state.copyWith(
        paginationStatus: FeedbackStatus.feedbackSuccess,
        feedbacks: state.feedbackModelList));
  }

  Future<void> _onGetUserData(
      OnGetUserDataEvent event, Emitter<FeedbackState> emit) async {
    final response = await getUserDataUseCase.call();
    response.fold((l) {
      emit(state.copyWith(
          feedbackListStatus: FeedbackStatus.feedbackFailure,
          failureMsg: 'failed to get user data.'));
    }, (userModel) {
      if (userModel.username != null) {
        String name = userModel.username!;
        if (name.length > 20) {
          name = "${userModel.username!.substring(0, 21)}...";
        }
        emit(state.copyWith(username: name));
      }
    });
  }

  void _onCategoryChange(
      OnCategoryChangeEvent event, Emitter<FeedbackState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onAnonymousChange(
      OnAnonymousChangeEvent event, Emitter<FeedbackState> emit) {
    emit(state.copyWith(isAnonymous: event.isAnonymous));
  }
}
