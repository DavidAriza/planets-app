import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/di/injector.dart';
import 'package:planets_app/core/shared/presentation/widgets/background_scaffold.dart';
import 'package:planets_app/domain/entities/planet.dart';
import 'package:planets_app/presentation/pages/planets/widgets/empty_planet_list.dart';
import 'package:planets_app/presentation/pages/planets/widgets/planet_vertical_card.dart';
import 'package:planets_app/presentation/pages/planets/widgets/planets_horizontal_card.dart';
import 'package:planets_app/presentation/pages/planets/widgets/search_field.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_state.dart';

class PlanetsPage extends ConsumerWidget {
  const PlanetsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planetsState = ref.watch(planetsNotifierProvider);

    return BackgroundScaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SearchField(),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;

                switch (planetsState.status) {
                  case PlanetsStatus.initial || PlanetsStatus.loading:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  case PlanetsStatus.success:
                    // Check if planets list is empty even when status is success
                    if (planetsState.planets.isEmpty) {
                      return const EmptyPlanetList();
                    }
                    return _PlanetList(width: width, planets: planetsState.planets);
                  case PlanetsStatus.error:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${planetsState.errorMessage}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.read(planetsNotifierProvider.notifier).loadPlanets(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                }
              }),
            ),
          ],
        ),
      ),
    ));
  }
}

class _PlanetList extends StatelessWidget {
  final double width;
  final List<Planet> planets;

  const _PlanetList({
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
          return PlanetHorizontalCard(
            planet: planet,
            onTap: () => _navigateToDetails(context, planet.name!),
          );
        },
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.75,
        ),
        itemCount: planets.length,
        itemBuilder: (BuildContext context, int index) {
          final planet = planets[index];
          return PlanetVerticalCard(
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
