abstract class Failure {}

class InternetFailure extends Failure {}

class SocketFailure extends Failure {}

class ServerFailure extends Failure {
  final String? error;

  ServerFailure({this.error});
}

class UnknownFailure extends Failure {}

class AuthFailure extends Failure {
  final String? error;

  AuthFailure({this.error});
}
