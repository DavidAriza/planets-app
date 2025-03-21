import 'package:planets_app/core/errors/failure.dart';

class ExceptionFailure extends Failure {
  final Exception? error;
  @override
  final String message;
  ExceptionFailure._({
    required this.message,
    this.error,
  });
  factory ExceptionFailure.decode(Exception? error) {
    return ExceptionFailure._(
      error: error,
      message: error.toString(),
    );
  }
}
