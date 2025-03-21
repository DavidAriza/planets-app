import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/use_cases/add_planet_to_favorites_use_case.dart';
import 'package:planets_app/domain/use_cases/get_planets_use_case.dart';
import 'package:planets_app/domain/use_cases/is_in_favorites_use_case.dart';
import 'package:planets_app/domain/use_cases/remove_planet_from_favorites_use_case.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanetsNotifier extends StateNotifier<PlanetsState> {
  final GetPlanetsUseCase getPlanetsUseCase;
  final AddPlanetToFavoritesUseCase addPlanetToFavorites;
  final RemovePlanetFromFavoritesUseCase removePlanetFromFavorites;
  final GetIsInFavoritesUseCase isInFavorites;

  PlanetsNotifier({
    required this.getPlanetsUseCase,
    required this.addPlanetToFavorites,
    required this.removePlanetFromFavorites,
    required this.isInFavorites,
  }) : super(PlanetsState()) {
    loadPlanets();
  }

  List<Planet>? _planets;

  Future<void> loadPlanets() async {
    // Set loading state but preserve other state properties
    state = state.copyWith(status: PlanetsStatus.loading, selectedPlanet: null);

    final result = await getPlanetsUseCase.call(NoParams());

    result.fold((failure) {
      // On failure, update state with error but preserve other properties
      state = state.copyWith(errorMessage: failure.message, status: PlanetsStatus.error);
    }, (planets) {
      // Only update if we actually got planets
      if (planets.isNotEmpty) {
        _planets = planets;
        state = state.copyWith(planets: planets, status: PlanetsStatus.success);
      } else {
        // Handle empty planets case - still mark as success but with empty list
        _planets = [];
        state = state.copyWith(planets: const [], status: PlanetsStatus.success);
        // You might want to log this for debugging
      }
    });
  }

  Future<void> searchPlanets(String query) async {
    if (_planets == null) {
      await loadPlanets();
      if (_planets == null) return;
    }

    if (query.isEmpty) {
      state = state.copyWith(planets: _planets, status: PlanetsStatus.success);
      return;
    }

    final filteredPlanets = _planets!.where((planet) {
      final name = planet.name?.toLowerCase() ?? '';
      final mass = planet.mass?.toLowerCase() ?? '';
      final radius = planet.orbitalDisctance?.toString().toLowerCase() ?? '';

      final searchLower = query.toLowerCase();

      return name.contains(searchLower) || mass.contains(searchLower) || radius.contains(searchLower);
    }).toList();

    state = state.copyWith(planets: filteredPlanets, status: PlanetsStatus.success);
  }

  Future<void> loadPlanetDetails(String planetName) async {
    state = state.copyWith(status: PlanetsStatus.loading);

    if (_planets == null || _planets!.isEmpty) {
      await loadPlanets();
      if (_planets == null || _planets!.isEmpty) {
        state = state.copyWith(status: PlanetsStatus.error);
        return;
      }
    }

    final foundPlanets = _planets!.where(
      (planet) => planet.name!.toLowerCase() == planetName.toLowerCase(),
    );

    final foundPlanet = foundPlanets.isNotEmpty ? foundPlanets.first : null;

    if (foundPlanet != null) {
      state = state.copyWith(
        selectedPlanet: foundPlanet,
        status: PlanetsStatus.success,
      );
      checkIfPlanetIsInFavorites(foundPlanet.name!);
    } else {
      // Solo cambiamos a notFound
      state = state.copyWith(status: PlanetsStatus.notFound);
      // No necesitas hacer nada más aquí, la redirección se maneja en GoRouter
    }
  }

  Future<void> addFavoritePlanetToList(Planet planet) async {
    final updatedFavorites = List<Planet>.from(state.favoritePlanets);
    updatedFavorites.add(planet);

    state = state.copyWith(favoritePlanets: updatedFavorites);

    final result = await addPlanetToFavorites.call(planet);
    result.fold((failure) => state = state.copyWith(status: PlanetsStatus.error, errorMessage: failure.message),
        (unit) => state = state.copyWith(selectedPlanet: state.selectedPlanet?.copyWith(isInFavorites: true)));
  }

  Future<void> removePlanetFromFavoritesList(String name) async {
    final updatedFavorites = List<Planet>.from(state.favoritePlanets);
    updatedFavorites.removeWhere((planet) => planet.name == name);

    state = state.copyWith(favoritePlanets: updatedFavorites);

    final result = await removePlanetFromFavorites.call(name);
    result.fold((failure) => state = state.copyWith(status: PlanetsStatus.error, errorMessage: failure.message),
        (unit) => state = state.copyWith(selectedPlanet: state.selectedPlanet?.copyWith(isInFavorites: false)));
  }

  Future<void> checkIfPlanetIsInFavorites(String name) async {
    final result = await isInFavorites.call(name);
    result.fold(
        (failure) => state = state.copyWith(
              status: PlanetsStatus.notFavorite,
            ),
        (planet) => state = state.copyWith(
              selectedPlanet: state.selectedPlanet?.copyWith(isInFavorites: planet != null),
            ));
  }
}
