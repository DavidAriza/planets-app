import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/constants/app_constants.dart';
import 'package:planets_app/core/shared/presentation/widgets/background_scaffold.dart';
import 'package:planets_app/core/shared/presentation/widgets/planet_error_image.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/add_to_favorite_button.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/info_row.dart';

class MobileDetail extends StatelessWidget {
  const MobileDetail({
    super.key,
    required this.planet,
  });

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BackgroundScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: kIsWeb ? '${AppConstants.proxyImage}${planet.image!}' : planet.image!,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => PlanetErrorImage(planetName: planet.name!),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 10,
                  child: IconButton(
                    onPressed: () => context.go('/planets'),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        planet.name!,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 10),
                      PlanetFavoriteButton(planet: planet),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    planet.description!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 24),
                  InfoRow(label: 'Distance from Sun: ', value: '${planet.orbitalDisctance} million km'),
                  InfoRow(label: 'Mass: ', value: '${planet.mass}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
