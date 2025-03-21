import 'package:flutter/material.dart';

class EmptyPlanetList extends StatelessWidget {
  const EmptyPlanetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No planets found', style: TextStyle(color: Colors.white)),
    );
  }
}
