import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  User? call() {
    return authRepository.getCurrentUser();
  }
}
