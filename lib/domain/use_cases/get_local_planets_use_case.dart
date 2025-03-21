import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/repository/planets_local_repository.dart';

class GetLocalPlanetsUseCase implements UseCase<List<Planet>, NoParams> {
  final PlanetsLocalRepository planetsLocalRepository;

  GetLocalPlanetsUseCase({required this.planetsLocalRepository});

  @override
  Future<Either<Failure, List<Planet>>> call(NoParams noParams) async {
    return Future.value(planetsLocalRepository.getFavoritePlanets());
  }
}
