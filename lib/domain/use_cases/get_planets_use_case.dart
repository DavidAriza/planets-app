import 'package:dartz/dartz.dart';
import 'package:planets_app/core/errors/failure.dart';
import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/repository/planets_repository.dart';

class GetPlanetsUseCase implements UseCase<List<Planet>, NoParams> {
  final PlanetsRepository repository;
  GetPlanetsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Planet>>> call(NoParams noParams) {
    return repository.getPlanets();
  }
}
