abstract class Failure {}

// General failures
class ServerFailure extends Failure {
  String message = "";

  ServerFailure(this.message);
}

class InternetFailure extends Failure {
  String message = "";

  InternetFailure(this.message);
}

class FailureMessage extends Failure {
  String message;

  FailureMessage(this.message);
}
