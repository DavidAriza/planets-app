import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';

import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/repository/planets_local_repository.dart';

class AddPlanetToFavoritesUseCase extends UseCase<Unit, Planet> {
  final PlanetsLocalRepository planetsLocalRepository;

  AddPlanetToFavoritesUseCase({required this.planetsLocalRepository});

  @override
  Future<Either<Failure, Unit>> call(Planet planet) async {
    return await planetsLocalRepository.addPlanetToFavorites(planet);
  }
}
