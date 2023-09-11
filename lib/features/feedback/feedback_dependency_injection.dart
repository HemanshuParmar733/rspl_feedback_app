import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource.dart';
import 'package:feedback_app/features/feedback/data/data_source/remote/feedback_datasource_impl.dart';
import 'package:feedback_app/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:feedback_app/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:feedback_app/features/feedback/domain/usecases/create_new_feedback_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_paginated_feedbacks_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/get_userdata_usecase.dart';
import 'package:feedback_app/features/feedback/domain/usecases/update_feedback_usecase.dart';
import 'package:feedback_app/features/feedback/presentation/cubit/feed_back_cubit.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecases/get_all_feedback_categories.dart';

final slFeedback = GetIt.instance;

Future<void> initFeedbackDependencies() async {
  // data source
  slFeedback.registerLazySingleton<FeedbackDataSource>(
      () => FeedbackDataSourceImpl(slFeedback.call()));

  // repositories
  slFeedback.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(slFeedback.call()));

  // usecases
  slFeedback.registerLazySingleton<GetPaginatedFeedbacksUseCase>(
      () => GetPaginatedFeedbacksUseCase(slFeedback.call()));
  slFeedback.registerLazySingleton<CreateNewFeedbackUseCase>(
      () => CreateNewFeedbackUseCase(slFeedback.call()));
  slFeedback.registerLazySingleton<GetAllFeedbackCategoriesUseCase>(
      () => GetAllFeedbackCategoriesUseCase(slFeedback.call()));
  slFeedback.registerLazySingleton<UpdateFeedbackUseCase>(
      () => UpdateFeedbackUseCase(slFeedback.call()));
  slFeedback.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(slFeedback.call()));

  // cubit
  slFeedback.registerFactory<FeedBackCubit>(() => FeedBackCubit());
}
