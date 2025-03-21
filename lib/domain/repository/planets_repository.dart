import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/domain/entities/planet.dart';

abstract class PlanetsRepository {
  Future<Either<Failure, List<Planet>>> getPlanets();
}
