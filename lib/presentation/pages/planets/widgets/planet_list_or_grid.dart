import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/presentation/pages/planets/widgets/planet_grid_view_card.dart';
import 'package:planets_app/presentation/pages/planets/widgets/planet_list_view_card.dart';

class PlanetListOrGrid extends StatelessWidget {
  final double width;
  final List<Planet> planets;

  const PlanetListOrGrid({
    required this.width,
    required this.planets,
  });

  @override
  Widget build(BuildContext context) {
    // We know planets is not empty at this point, so no need to check again

    final crossAxisCount = width >= 1200
        ? 4
        : width >= 900
            ? 3
            : 2;

    if (width < 600) {
      return ListView.builder(
        itemCount: planets.length,
        itemBuilder: (BuildContext context, int index) {
          final planet = planets[index];
          return PlanetListViewCard(
            planet: planet,
            onTap: () => _navigateToDetails(context, planet.name!),
          );
        },
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.75,
        ),
        itemCount: planets.length,
        itemBuilder: (BuildContext context, int index) {
          final planet = planets[index];
          return PlanetGridViewCard(
            planet: planet,
            onTap: () => _navigateToDetails(context, planet.name!),
          );
        },
      );
    }
  }

  void _navigateToDetails(BuildContext context, String planetName) {
    context.go('/planets/$planetName');
  }
}
