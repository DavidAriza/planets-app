import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanetNotFound extends ConsumerWidget {
  final VoidCallback onTap;
  const PlanetNotFound({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Planet not found',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: onTap,
            child: const Text('Go to planet list!'),
          ),
        ],
      ),
    );
  }
}
