import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/repository/planets_local_repository.dart';

class GetIsInFavoritesUseCase implements UseCase<Planet?, String> {
  final PlanetsLocalRepository planetsLocalRepository;

  GetIsInFavoritesUseCase({required this.planetsLocalRepository});

  @override
  Future<Either<Failure, Planet?>> call(String name) async {
    return Future.value(planetsLocalRepository.isInFavorites(name));
  }
}
