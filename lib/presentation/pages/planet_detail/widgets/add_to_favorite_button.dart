import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/di/injector.dart';
import 'package:planets_app/domain/entities/planet.dart';

class PlanetFavoriteButton extends ConsumerWidget {
  final Planet planet;

  const PlanetFavoriteButton({
    Key? key,
    required this.planet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlanet = ref.watch(planetsNotifierProvider).selectedPlanet;
    final bool isFavorite = selectedPlanet?.name == planet.name ? selectedPlanet!.isInFavorites ?? false : false;

    final notifier = ref.watch(planetsNotifierProvider.notifier);

    return _AddToFavoritesButton(
      onTap: () {
        if (isFavorite) {
          notifier.removePlanetFromFavoritesList(planet.name!);
        } else {
          notifier.addFavoritePlanetToList(planet);
        }
      },
      isFavorite: isFavorite,
    );
  }
}

class _AddToFavoritesButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isFavorite;
  const _AddToFavoritesButton({required this.onTap, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.pink : Colors.white, size: 22),
    );
  }
}
