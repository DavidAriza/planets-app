import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/shared/presentation/widgets/background_scaffold.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/add_to_favorite_button.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/info_row.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';

class WebDetail extends StatelessWidget {
  const WebDetail({
    super.key,
    required this.planet,
  });

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Hero(
                  tag: planet.name!,
                  child: CachedNetworkImage(
                    imageUrl: planet.image!,
                    imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
                    fit: BoxFit.contain,
                    errorWidget: (context, error, stackTrace) {
                      return Image.network(
                          'https://cdn.dribbble.com/users/1274627/screenshots/3390285/404-error-sad-boat-800x600.jpg');
                    },
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          planet.name!,
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        PlanetFavoriteButton(planet: planet)
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      planet.description!,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 32),
                    InfoRow(label: 'Distance from Sun: ', value: '${planet.orbitalDisctance} million km'),
                    InfoRow(label: 'Mass: ', value: '${planet.mass}'),
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
