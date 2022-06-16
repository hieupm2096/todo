abstract class Failure {
  final String? message;

  const Failure({this.message});
}

// Local Database Failure
class DatabaseFailure extends Failure {
  const DatabaseFailure() : super(message: "Well, there's something wrong with the storage");
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super(message: "Seems like there's something wrong with your task");
}
