import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/add_to_favorite_button.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/info_row.dart';

class WebDetail extends StatelessWidget {
  const WebDetail({
    super.key,
    required this.planet,
  });

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        planet.image!,
                        fit: BoxFit.contain,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
