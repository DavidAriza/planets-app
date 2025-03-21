import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/domain/entities/planet.dart';

abstract class PlanetsLocalRepository {
  Either<Failure, List<Planet>> getFavoritePlanets();
  Future<Either<Failure, Unit>> addPlanetToFavorites(Planet item);
  Future<Either<Failure, Unit>> removePlanetFromFavorites(String name);
  Either<Failure, Planet?> isInFavorites(String name);
}
