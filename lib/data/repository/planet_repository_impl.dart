import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/data/data_sources/planets_remote_data_source.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/repository/planets_repository.dart';

class PlanetsRepositoryImpl implements PlanetsRepository {
  final PlanetsRemoteDataSource planetsRemoteDataSource;

  PlanetsRepositoryImpl({required this.planetsRemoteDataSource});
  @override
  Future<Either<Failure, List<Planet>>> getPlanets() async {
    try {
      final planetModels = await planetsRemoteDataSource.getPlanets();
      final planets = planetModels
          .map(
            (planet) => planet.toEntity(),
          )
          .toList();
      return Right(planets);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
