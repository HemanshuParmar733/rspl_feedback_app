import 'package:dartz/dartz.dart';
import 'package:feedback_app/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/failure/failures.dart';

class LoginWithEmailUseCase {
  final AuthRepository authRepository;

  LoginWithEmailUseCase(this.authRepository);

  Future<Either<Failure, bool>> call(
      {required String email, required String password}) async {
    return authRepository.loginWithEmailPassword(email, password);
  }
}
