import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/constants/app_constants.dart';
import 'package:planets_app/core/shared/presentation/widgets/background_scaffold.dart';
import 'package:planets_app/core/shared/presentation/widgets/planet_error_image.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/add_to_favorite_button.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/info_row.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WebDetail extends StatelessWidget {
  const WebDetail({
    super.key,
    required this.planet,
  });

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Space-themed dark background
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          // Prevents content from being too stretched
          child: Row(
            children: [
              /// **Left - Planet Image**
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: '${AppConstants.proxyImage}${planet.image!}',
                        imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => PlanetErrorImage(planetName: planet.name!),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () => context.go('/planets'),
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),

              /// **Right - Details Section**
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// **Planet Name + Favorite Button**
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            planet.name!,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          PlanetFavoriteButton(planet: planet),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// **Planet Description**
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white12.withOpacity(0.2), // Semi-transparent background
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        planet.description!,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// **Planet Info**
                    InfoRow(
                      label: 'Distance from Sun:',
                      value: '${planet.orbitalDisctance} million km',
                    ),
                    const SizedBox(height: 12),
                    InfoRow(
                      label: 'Mass:',
                      value: '${planet.mass}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
