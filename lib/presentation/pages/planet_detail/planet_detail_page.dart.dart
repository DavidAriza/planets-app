import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/di/injector.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/mobile_planet_detail.dart';
import 'package:planets_app/presentation/pages/planet_detail/widgets/web_planet_detail.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_state.dart';

class PlanetDetailPage extends ConsumerStatefulWidget {
  final String planetName;
  const PlanetDetailPage({super.key, required this.planetName});

  @override
  ConsumerState<PlanetDetailPage> createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends ConsumerState<PlanetDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(planetsNotifierProvider.notifier).loadPlanetDetails(widget.planetName));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(planetsNotifierProvider);
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (state.status == PlanetsStatus.loading || state.status == PlanetsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage!),
                  ElevatedButton(
                    onPressed: () => ref.read(planetsNotifierProvider.notifier).loadPlanetDetails(widget.planetName),
                    child: const Text('Go to planet list!'),
                  ),
                ],
              ),
            );
          } else if (state.selectedPlanet != null) {
            return LayoutBuilder(
              builder: (ctx, constraints) {
                if (constraints.maxWidth > 600) {
                  return WebDetail(planet: state.selectedPlanet!);
                } else {
                  return MobileDetail(planet: state.selectedPlanet!);
                }
              },
            );
          } else {
            return const Center(child: Text('Loading details...'));
          }
        },
      ),
    );
  }
}
