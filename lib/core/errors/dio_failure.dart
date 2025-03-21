import 'package:dio/dio.dart';
import 'package:planets_app/core/errors/failure.dart';

class DioFailure extends Failure {
  final int? statusCode;
  final Map<String, dynamic>? data;
  final DioException? error;
  @override
  final String message;
  DioFailure._({
    required this.message,
    this.statusCode,
    this.data,
    this.error,
  });
  factory DioFailure.decode(
    DioException? error,
  ) {
    return DioFailure._(
      error: error,
      statusCode: error?.response?.statusCode,
      message: error?.message ?? '',
      data: error?.response?.data,
    );
  }
}
