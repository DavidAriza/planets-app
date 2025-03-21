import 'package:planets_app/core/errors/failure.dart';

class ErrorFailure extends Failure {
  final Error? error;
  @override
  final String message;
  ErrorFailure._({
    required this.message,
    this.error,
  });
  factory ErrorFailure.decode(
    Error? error,
  ) {
    return ErrorFailure._(
      error: error,
      message: error.toString(),
    );
  }
}
