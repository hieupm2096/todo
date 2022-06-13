abstract class Failure {
  final String? message;

  const Failure({this.message});
}

// Local Database Failure
class DatabaseFailure extends Failure {

  const DatabaseFailure() : super();
}