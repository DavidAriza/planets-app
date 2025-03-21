import 'package:planets_app/domain/entities/planet.dart';

// ignore: must_be_immutable
class PlanetModel extends Planet {
  PlanetModel({
    super.name,
    super.mass,
    super.orbitalDisctance,
    super.image,
    super.description,
    super.isInFavorites,
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json) {
    return PlanetModel(
        name: json['name'] ?? '',
        mass: json['mass_kg'] ?? '',
        orbitalDisctance: json['orbital_distance_km'] ?? 0,
        image: json['image'],
        description: json['description']);
  }

  Planet toEntity() =>
      Planet(name: name, mass: mass, orbitalDisctance: orbitalDisctance, image: image, description: description);

  factory PlanetModel.fromEntity(Planet planet) {
    return PlanetModel(
      name: planet.name,
      mass: planet.mass,
      orbitalDisctance: planet.orbitalDisctance,
      image: planet.image,
      description: planet.description,
    );
  }
}
