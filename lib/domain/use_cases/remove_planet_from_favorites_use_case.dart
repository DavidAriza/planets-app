import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/repository/planets_local_repository.dart';

class RemovePlanetFromFavoritesUseCase implements UseCase<Unit, String> {
  final PlanetsLocalRepository planetsLocalRepository;

  RemovePlanetFromFavoritesUseCase({required this.planetsLocalRepository});

  @override
  Future<Either<Failure, Unit>> call(String name) async {
    return await planetsLocalRepository.removePlanetFromFavorites(name);
  }
}
