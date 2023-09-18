import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:feedback_app/core/constants/shared_pref_keys.dart';
import 'package:feedback_app/core/database/shared_pref_storage.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:feedback_app/features/authentication/domain/usecases/login_with_email_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/register_new_user_usecase.dart';
import 'package:feedback_app/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:feedback_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterNewUserUseCase extends Mock
    implements RegisterNewUserUseCase {}

class MockLoginWithEmailUseCase extends Mock implements LoginWithEmailUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockSharedPreferences extends Mock implements SharedPrefStorage {}

void main() {
  late AuthBloc authBloc;
  late RegisterNewUserUseCase registerNewUserUseCase;
  late LoginWithEmailUseCase loginWithEmailUseCase;
  late SignOutUseCase signOutUseCase;
  late SharedPrefStorage preferences;
  final userModel =
      UserModel(uid: "1", username: "user", email: "abc@gmail.com");

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseCoreMocks();
    preferences = MockSharedPreferences();
    registerNewUserUseCase = MockRegisterNewUserUseCase();
    loginWithEmailUseCase = MockLoginWithEmailUseCase();
    signOutUseCase = MockSignOutUseCase();

    authBloc = AuthBloc(
        sharedPrefStorage: preferences,
        loginWithEmailUseCase: loginWithEmailUseCase,
        registerNewUserUseCase: registerNewUserUseCase,
        signOutUseCase: signOutUseCase);
  });

  group('Auth Bloc test', () {
    blocTest<AuthBloc, AuthState>("OnLoginEvent_success_isReturningTrue",
        build: () {
          when(() => loginWithEmailUseCase.call(
                  email: any(named: "email"), password: any(named: "password")))
              .thenAnswer((_) async => const Right(true));
          when(() => preferences.setBoolData(
              key: SharedPrefKeys.userLoginKey,
              data: true)).thenAnswer((_) async => true);
          return authBloc;
        },
        act: (bloc) => bloc.add(
            const OnLoginEvent(email: "abc@gmail.com", password: "123456")),
        verify: (bloc) {
          verify(() => bloc.loginWithEmailUseCase.call(
              email: any(named: 'email'),
              password: any(named: 'password'))).called(1);
          expectLater(bloc.state.isLogin, true);
        });
    blocTest<AuthBloc, AuthState>("OnRegisterEvent_success_isReturningTrue",
        build: () {
          when(() => registerNewUserUseCase.call(
              email: any(named: "email"),
              password: any(named: "password"),
              userModel: userModel)).thenAnswer((_) async => const Right(true));
          when(() => preferences.setBoolData(
              key: SharedPrefKeys.userLoginKey,
              data: true)).thenAnswer((_) async => true);
          return authBloc;
        },
        act: (bloc) => bloc.add(OnRegisterEvent(
            email: "abc@gmail.com", password: "123456", userModel: userModel)),
        verify: (bloc) {
          expectLater(bloc.state.isRegister, true);
        });
    blocTest<AuthBloc, AuthState>("OnLogEvent_success_isSuccess",
        build: () {
          when(() => signOutUseCase.call())
              .thenAnswer((invocation) => Future.value());
          when(() => preferences.deleteData(
                key: SharedPrefKeys.userLoginKey,
              )).thenAnswer((_) async => true);
          return authBloc;
        },
        act: (bloc) => bloc.add(const OnLogOutEvent()),
        verify: (bloc) {
          verify(() => bloc.signOutUseCase.call()).called(1);
        });

    blocTest<AuthBloc, AuthState>(
        "OnPasswordVisibilityChangeEvent_success_isChangingPasswordVisibilityBoolean",
        build: () {
          return authBloc;
        },
        seed: () => const AuthState(obscurePassword: false),
        act: (bloc) =>
            bloc.add(const OnTogglePasswordVisibilityEvent(value: false)),
        verify: (bloc) {
          expectLater(bloc.state.obscurePassword, true);
        });

    blocTest<AuthBloc, AuthState>(
        "OnConfirmPasswordVisibilityChangeEvent_success_isChangingConfirmPasswordVisibilityBoolean",
        build: () {
          return authBloc;
        },
        seed: () => const AuthState(obscurePassword: false),
        act: (bloc) => bloc
            .add(const OnToggleConfirmPasswordVisibilityEvent(value: false)),
        verify: (bloc) {
          expectLater(bloc.state.obscureConfirmPassword, true);
        });
  });
}
