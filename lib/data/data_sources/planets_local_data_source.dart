import 'package:hive_flutter/hive_flutter.dart';
import 'package:planets_app/data/models/planet_model.dart';
import 'package:planets_app/domain/entities/planet.dart';

abstract class PlanetsLocalDataSource {
  Future<void> addPlanetToFavorites(PlanetModel item);
  Future<void> removePlanetFromFavorites(String name);
  PlanetModel? isInFavorites(String name);
}

class PlanetsLocalDataSourceImpl implements PlanetsLocalDataSource {
  final Box<Planet> _planetsBox = Hive.box<Planet>('planets');

  @override
  Future<void> addPlanetToFavorites(PlanetModel item) async {
    await _planetsBox.put(item.name, item);
  }

  @override
  Future<void> removePlanetFromFavorites(String name) async {
    await _planetsBox.delete(name);
  }

  @override
  PlanetModel? isInFavorites(String name) {
    try {
      if (_planetsBox.isEmpty) return null;

      final exists = _planetsBox.values.any((element) => element.name == name);

      if (!exists) return null;

      Planet movie = _planetsBox.values.firstWhere((element) => element.name == name);
      return PlanetModel.fromEntity(movie);
    } catch (e) {
      return null;
    }
  }
}
