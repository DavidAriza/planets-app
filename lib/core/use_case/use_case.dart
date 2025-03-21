import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:planets_app/core/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params p);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
