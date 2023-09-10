import 'package:dartz/dartz.dart';
import 'package:feedback_app/features/authentication/data/models/user_model.dart';

import '../../../../core/failure/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterNewUserUseCase {
  final AuthRepository authRepository;

  RegisterNewUserUseCase(this.authRepository);

  Future<Either<Failure, bool>> call(
      {required String email,
      required String password,
      required UserModel userModel}) async {
    return authRepository.registerNewUser(
        email: email, password: password, userModel: userModel);
  }
}
