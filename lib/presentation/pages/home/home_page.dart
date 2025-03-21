import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/shared/presentation/widgets/background_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      body: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => context.go('/planets'),
          child: Text(
            'Ver planetas',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
