import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planets_app/core/router/app_router.dart';
import 'package:planets_app/domain/entities/planet.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlanetAdapter());
  await Hive.openBox<Planet>('planets');
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
