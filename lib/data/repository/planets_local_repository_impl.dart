import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/core/errors/hive_failure.dart';
import 'package:planets_app/data/data_sources/planets_local_data_source.dart';
import 'package:planets_app/data/models/planet_model.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/repository/planets_local_repository.dart';

class PlanetsLocalRepositoryImpl implements PlanetsLocalRepository {
  final PlanetsLocalDataSource planetsLocalDataSource;

  PlanetsLocalRepositoryImpl({required this.planetsLocalDataSource});

  @override
  Future<Either<Failure, Unit>> addPlanetToFavorites(Planet item) async {
    try {
      final planetModel = PlanetModel.fromEntity(item);
      planetsLocalDataSource.addPlanetToFavorites(planetModel);
      return Right(unit);
    } on HiveError catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> removePlanetFromFavorites(String name) async {
    try {
      await planetsLocalDataSource.removePlanetFromFavorites(name);
      return Right(unit);
    } on HiveError catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Either<Failure, Planet?> isInFavorites(String name) {
    try {
      return Right(planetsLocalDataSource.isInFavorites(name)?.toEntity());
    } on HiveError catch (e) {
      return Left(HiveFailure(e.message));
    }
  }
}
