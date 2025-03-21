import 'package:go_router/go_router.dart';
import 'package:planets_app/presentation/pages/home/home_page.dart';
import 'package:planets_app/presentation/pages/planet_detail/planet_detail_page.dart.dart';
import 'package:planets_app/presentation/pages/planets/planets_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/planets',
      builder: (context, state) => PlanetsPage(),
      routes: [
        // Nested route for planet details
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final String planetId = state.pathParameters['id']!;
            return PlanetDetailPage(planetName: planetId);
          },
        ),
      ],
    ),
  ],
);
