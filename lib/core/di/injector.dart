import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/network/dio_http_client.dart';
import 'package:planets_app/data/data_sources/planets_local_data_source.dart';
import 'package:planets_app/data/data_sources/planets_remote_data_source.dart';
import 'package:planets_app/data/repository/planet_repository_impl.dart';
import 'package:planets_app/data/repository/planets_local_repository_impl.dart';
import 'package:planets_app/domain/repository/planets_local_repository.dart';
import 'package:planets_app/domain/repository/planets_repository.dart';
import 'package:planets_app/domain/use_cases/add_planet_to_favorites_use_case.dart';
import 'package:planets_app/domain/use_cases/get_local_planets_use_case.dart';
import 'package:planets_app/domain/use_cases/get_planets_use_case.dart';
import 'package:planets_app/domain/use_cases/is_in_favorites_use_case.dart';
import 'package:planets_app/domain/use_cases/remove_planet_from_favorites_use_case.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_notifier.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_state.dart';

final httpClientProvider = Provider<DioHttpClientImplementation>(
  (ref) {
    return DioHttpClientImplementation(
        Dio(BaseOptions(baseUrl: 'https://us-central1-a-academia-espacial.cloudfunctions.net/')));
  },
);

final planetsRemoteDataSourceProvider = Provider<PlanetsRemoteDataSource>((ref) {
  return PlanetsRemoteDataSourceImpl(client: ref.watch(httpClientProvider));
});

final planetsRepositoryProvider = Provider<PlanetsRepository>((ref) {
  return PlanetsRepositoryImpl(
    planetsRemoteDataSource: ref.watch(planetsRemoteDataSourceProvider),
  );
});

final getPlanetsUseCaseProvider = Provider<GetPlanetsUseCase>((ref) {
  return GetPlanetsUseCase(
    repository: ref.watch(planetsRepositoryProvider),
  );
});

/// Providers for local storage

final planetsLocalDataSourceProvider = Provider<PlanetsLocalDataSource>((ref) {
  return PlanetsLocalDataSourceImpl();
});

final planetsLocalRepositoryProvider = Provider<PlanetsLocalRepository>((ref) {
  return PlanetsLocalRepositoryImpl(
    planetsLocalDataSource: ref.watch(planetsLocalDataSourceProvider),
  );
});

final getLocalPlanetsUseCaseProvider = Provider<GetLocalPlanetsUseCase>((ref) {
  return GetLocalPlanetsUseCase(
    planetsLocalRepository: ref.watch(planetsLocalRepositoryProvider),
  );
});
final addPlanetToFavoritesUseCaseProvider = Provider<AddPlanetToFavoritesUseCase>((ref) {
  return AddPlanetToFavoritesUseCase(
    planetsLocalRepository: ref.watch(planetsLocalRepositoryProvider),
  );
});
final removeFromFavoritesUseCaseProvider = Provider<RemovePlanetFromFavoritesUseCase>((ref) {
  return RemovePlanetFromFavoritesUseCase(
    planetsLocalRepository: ref.watch(planetsLocalRepositoryProvider),
  );
});
final isInFavoritesUseCaseProvider = Provider<GetIsInFavoritesUseCase>((ref) {
  return GetIsInFavoritesUseCase(
    planetsLocalRepository: ref.watch(planetsLocalRepositoryProvider),
  );
});

/// STATE NOTIFIER
final planetsNotifierProvider = StateNotifierProvider<PlanetsNotifier, PlanetsState>((ref) {
  return PlanetsNotifier(
      getPlanetsUseCase: ref.watch(getPlanetsUseCaseProvider),
      getLocalPlanets: ref.watch(getLocalPlanetsUseCaseProvider),
      addPlanetToFavorites: ref.watch(addPlanetToFavoritesUseCaseProvider),
      removePlanetFromFavorites: ref.watch(removeFromFavoritesUseCaseProvider),
      isInFavorites: ref.watch(isInFavoritesUseCaseProvider));
});
