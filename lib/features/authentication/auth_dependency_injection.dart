import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource.dart';
import 'package:feedback_app/features/authentication/data/data_source/remote/auth_datasource_impl.dart';
import 'package:feedback_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:feedback_app/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/login_with_email_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/register_new_user_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final slAuth = GetIt.instance;

Future<void> initAuthDependencies() async {
  // database
  slAuth.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  slAuth.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // data source
  slAuth.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(slAuth.call(), slAuth.call()));

  // repositories
  slAuth.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(slAuth.call()));

  // usecases
  slAuth.registerLazySingleton<LoginWithEmailUseCase>(
      () => LoginWithEmailUseCase(slAuth.call()));
  slAuth.registerLazySingleton<RegisterNewUserUseCase>(
      () => RegisterNewUserUseCase(slAuth.call()));
  slAuth.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(slAuth.call()));
  slAuth.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(slAuth.call()));

  // cubit
  slAuth.registerFactory<AuthCubit>(() => AuthCubit());
}
