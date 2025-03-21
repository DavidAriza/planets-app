import 'package:equatable/equatable.dart';
import 'package:planets_app/domain/entities/planet.dart';

enum PlanetsStatus { initial, loading, success, error, notFavorite, notFound }

class PlanetsState extends Equatable {
  final PlanetsStatus status;
  final List<Planet> planets;
  final List<Planet> favoritePlanets;
  final Planet? selectedPlanet;
  final String? errorMessage;

  const PlanetsState({
    this.status = PlanetsStatus.initial,
    this.planets = const [],
    this.favoritePlanets = const [],
    this.selectedPlanet,
    this.errorMessage,
  });

  PlanetsState copyWith({
    PlanetsStatus? status,
    List<Planet>? planets,
    List<Planet>? favoritePlanets,
    Planet? selectedPlanet,
    String? errorMessage,
  }) {
    return PlanetsState(
      status: status ?? this.status,
      planets: planets ?? this.planets,
      favoritePlanets: favoritePlanets ?? this.favoritePlanets,
      selectedPlanet: selectedPlanet ?? this.selectedPlanet,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, planets, favoritePlanets, selectedPlanet, errorMessage];
}
