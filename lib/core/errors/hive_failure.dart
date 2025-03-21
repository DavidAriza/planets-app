import 'package:planets_app/core/errors/failure.dart';

class HiveFailure extends Failure {
  final String _message;

  HiveFailure(this._message);
  @override
  String get message => _message;
}
