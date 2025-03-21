import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlanetErrorImage extends StatelessWidget {
  final String planetName;

  const PlanetErrorImage({super.key, required this.planetName});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$planetName${planetName == 'Neptune' ? '.jpeg' : '.jpg'}',
      fit: kIsWeb ? BoxFit.fitHeight : BoxFit.contain,
    );
  }
}
