import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/di/injector.dart';
import 'package:planets_app/core/shared/presentation/widgets/background_scaffold.dart';
import 'package:planets_app/core/shared/presentation/widgets/error_widget.dart';
import 'package:planets_app/presentation/pages/planets/widgets/empty_planet_list.dart';
import 'package:planets_app/presentation/pages/planets/widgets/planet_list_or_grid.dart';
import 'package:planets_app/presentation/pages/planets/widgets/search_field.dart';
import 'package:planets_app/presentation/providers/planets_provider/planets_state.dart';

class PlanetsPage extends ConsumerStatefulWidget {
  const PlanetsPage({super.key});

  @override
  ConsumerState<PlanetsPage> createState() => _PlanetsPageState();
}

class _PlanetsPageState extends ConsumerState<PlanetsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(planetsNotifierProvider.notifier).loadPlanets(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final planetsState = ref.watch(planetsNotifierProvider);
    final size = MediaQuery.of(context).size;
    return BackgroundScaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width > 600 ? 30 : 10.0),
        child: Column(
          children: [
            SearchField(),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;

                if (planetsState.status == PlanetsStatus.loading || planetsState.status == PlanetsStatus.initial) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (planetsState.status == PlanetsStatus.success || planetsState.status == PlanetsStatus.notFavorite) {
                  if (planetsState.planets.isEmpty) {
                    return const EmptyPlanetList();
                  }
                  return PlanetListOrGrid(width: width, planets: planetsState.planets);
                }

                if (planetsState.status == PlanetsStatus.error) {
                  return ErrorElement(
                    errorMessage: planetsState.errorMessage!,
                    onRetry: () => ref.read(planetsNotifierProvider.notifier).loadPlanets(),
                  );
                }

                return const Center(child: Text('Unexpected state', style: TextStyle(color: Colors.white)));
              }),
            ),
          ],
        ),
      ),
    ));
  }
}
