import 'package:bloc/bloc.dart' show Cubit;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/core/enums/user_action_enum.dart';
import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:feedback_app/features/feedback/domain/usecases/create_new_feedback_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_all_feedback_categories.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_all_feedbacks_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_userdata_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/update_feedback_usecase.dart';
import 'package:feedback_app/features/feedback/feedback_dependency_injection.dart';
import 'package:feedback_app/features/feedback/presentation/cubit/feed_back_state.dart';
import 'package:flutter/cupertino.dart';

class FeedBackCubit extends Cubit<FeedbackState> {
  FeedBackCubit() : super(const FeedbackInitial());
  final CreateNewFeedbackUseCase _createNewFeedbackUseCase =
      slFeedback<CreateNewFeedbackUseCase>();
  final GetAllFeedbacksUseCase _getAllFeedbacksUseCase =
      slFeedback<GetAllFeedbacksUseCase>();
  final GetAllFeedbackCategoriesUseCase _getAllFeedbackCategoriesUseCase =
      slFeedback<GetAllFeedbackCategoriesUseCase>();
  final UpdateFeedbackUseCase _updateFeedbackUseCase =
      slFeedback<UpdateFeedbackUseCase>();
  final GetUserDataUseCase _getUserDataUseCase =
      slFeedback<GetUserDataUseCase>();

  Future<void> getFeedbackCategories() async {
    final response = await _getAllFeedbackCategoriesUseCase.call();
    response.fold((l) {
      changeSuccessState(isLoading: false);
      debugPrint(l.toString());
      emit(const FeedbackFailure(errorMsg: 'Failed to get categories.'));
    }, (categoryModel) {
      changeSuccessState(
          categories: categoryModel.listOfCategories ?? ["Other"],
          selectedCategory: categoryModel.listOfCategories?.first);
    });
  }

  Future<void> createNewFeedback(FeedbackModel model) async {
    changeSuccessState(isLoading: true);
    final currentState = state as FeedbackSuccess;
    model.category = currentState.selectedCategory;
    model.reporterName =
        (currentState.isAnonymous ?? false) ? "Anonymous" : model.reporterName;

    try {
      // get user data
      final response = await _getUserDataUseCase.call();
      response.fold((l) {
        debugPrint(l.toString());
        emit(const FeedbackFailure(errorMsg: 'Failed to get user.'));
      }, (userModel) async {
        //fill user name
        model.userName = userModel.username;

        // create new feedback
        final response = await _createNewFeedbackUseCase.call(model);
        response.fold((l) {
          changeSuccessState(isLoading: false);
          debugPrint(l.toString());
          emit(const FeedbackFailure(errorMsg: 'Failed to create feedback.'));
        }, (bool isCreated) {
          // emit success
          changeSuccessState(isLoading: false);
          if (isCreated) {
            changeSuccessState(isFeedbackCreate: true);
          }
        });
      });
    } catch (e) {
      emit(FeedbackFailure(
          errorMsg: 'Failed to create feedback ${e.toString()}.'));
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllFeedbackStream() =>
      _getAllFeedbacksUseCase.call();

  void changeCategory(String? value) {
    changeSuccessState(selectedCategory: value);
  }

  void changeReporterVisibility(bool? value) {
    changeSuccessState(isAnonymous: value);
  }

  List<FeedbackModel> getFeedbackModelList(
      List<QueryDocumentSnapshot<Object?>>? docs) {
    List<FeedbackModel> feedbacks = [];
    docs?.forEach((element) {
      if (element.data() != null) {
        feedbacks.add(
            FeedbackModel.fromJson(element.data() as Map<String, dynamic>));
      }
    });
    return feedbacks;
  }

  void updateFeedback(
      FeedbackModel feedbackModel, UserAction userAction) async {
    final response =
        await _updateFeedbackUseCase.call(feedbackModel, userAction);
    response.fold((l) {
      emit(const FeedbackFailure(errorMsg: 'Failed to update feedback.'));
    }, (bool isUpdated) {
      if (isUpdated) {
        changeSuccessState(isFeedbackCreate: true);
      }
    });
  }

  Future<void> getUsername() async {
    final response = await _getUserDataUseCase.call();
    response.fold((l) {
      emit(const FeedbackFailure(errorMsg: 'Failed to get userdata.'));
    }, (userModel) {
      if (userModel.username != null) {
        String name = userModel.username!;
        if (name.length > 10) {
          name = userModel.username!.substring(0, 11);
        }
        changeSuccessState(username: name);
      }
    });
  }

  void changeSuccessState(
      {bool? isAnonymous,
      bool? isFeedbackCreate,
      bool? isLoading,
      bool? isUpdatingFeedback,
      String? selectedCategory,
      String? username,
      List<String>? categories}) {
    if (state is FeedbackSuccess) {
      final currentState = state as FeedbackSuccess;
      emit(currentState.copyWith(
          isAnonymous: isAnonymous ?? currentState.isAnonymous,
          isFeedbackCreate: isFeedbackCreate ?? currentState.isFeedbackCreate,
          username: username ?? currentState.username,
          isUpdatingFeedback:
              isUpdatingFeedback ?? currentState.isUpdatingFeedback,
          selectedCategory: selectedCategory ?? currentState.selectedCategory,
          feedbackCategories: categories ?? currentState.feedbackCategories,
          isLoading: isLoading ?? currentState.isLoading));
    } else {
      emit(FeedbackSuccess(
        isFeedbackCreate: isFeedbackCreate ?? false,
        isAnonymous: isAnonymous ?? false,
        isLoading: isLoading ?? false,
        username: username ?? "",
        isUpdatingFeedback: isUpdatingFeedback ?? false,
        selectedCategory: selectedCategory ?? "Other",
        feedbackCategories: categories ?? [],
      ));
    }
  }
}
