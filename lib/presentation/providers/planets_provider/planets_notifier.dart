import 'package:planets_app/core/use_case/use_case.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/domain/use_cases/add_planet_to_favorites_use_case.dart';
import 'package:planets_app/domain/use_cases/get_local_planets_use_case.dart';
import 'package:planets_app/domain/use_cases/get_planets_use_case.dart';
import 'package:planets_app/domain/use_cases/is_in_favorites_use_case.dart';
import 'package:planets_app/domain/use_cases/remove_planet_from_favorites_use_case.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanetsNotifier extends StateNotifier<PlanetsState> {
  final GetPlanetsUseCase getPlanetsUseCase;
  final GetLocalPlanetsUseCase getLocalPlanets;
  final AddPlanetToFavoritesUseCase addPlanetToFavorites;
  final RemovePlanetFromFavoritesUseCase removePlanetFromFavorites;
  final GetIsInFavoritesUseCase isInFavorites;

  PlanetsNotifier({
    required this.getPlanetsUseCase,
    required this.getLocalPlanets,
    required this.addPlanetToFavorites,
    required this.removePlanetFromFavorites,
    required this.isInFavorites,
  }) : super(PlanetsState()) {
    loadPlanets();
    getFavoritePlanets();
  }

  List<Planet>? _planets;

  Future<void> loadPlanets() async {
    // Set loading state but preserve other state properties
    state = state.copyWith(status: PlanetsStatus.loading);

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
        print('API returned empty planets list');
      }
    });
  }

  Future<void> getFavoritePlanets() async {
    // Here we only update the favorite planets, not the entire state
    final result = await getLocalPlanets.call(NoParams());

    result.fold((failure) {
      // Only update favorite planets related state
      state = state.copyWith(
        errorMessage: failure.message,
        // Don't change the main status if we're just loading favorites
      );
    }, (favoritePlanets) {
      // Update favorite planets without changing main status
      state = state.copyWith(
        favoritePlanets: favoritePlanets,
        // Don't change the main status if we're just loading favorites
      );
    });
  }

  Future<void> searchPlanets(String query) async {
    // Make sure planets are loaded before searching
    if (_planets == null) {
      await loadPlanets();
      // If still null after loading, return
      if (_planets == null) return;
    }

    if (query.isEmpty) {
      // Reset to full list when query is empty
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

    // Update state with filtered planets
    state = state.copyWith(planets: filteredPlanets, status: PlanetsStatus.success);
  }

  // Rest of your methods remain the same...
  Future<void> loadPlanetDetails(String planetName) async {
    if (_planets == null) {
      await loadPlanets();
    }
    if (_planets != null) {
      Planet? foundPlanet;
      for (final planet in _planets!) {
        if (planet.name!.toLowerCase() == planetName.toLowerCase()) {
          foundPlanet = planet;
          checkIfPlanetIsInFavorites(foundPlanet.name!);
          break;
        }
      }
      state = foundPlanet != null
          ? state.copyWith(selectedPlanet: foundPlanet)
          : state.copyWith(errorMessage: 'Planet not found', status: PlanetsStatus.error);
    } else {
      state = state.copyWith(errorMessage: 'Unable to load planets', status: PlanetsStatus.error);
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
        (failure) => state = state.copyWith(status: PlanetsStatus.error, errorMessage: failure.message),
        (planet) =>
            state = state.copyWith(selectedPlanet: state.selectedPlanet?.copyWith(isInFavorites: planet != null)));
  }
}
