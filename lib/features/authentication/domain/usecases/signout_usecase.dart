import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future<void> call() async {
    return authRepository.signOut();
  }
}
