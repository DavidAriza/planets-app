import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/di/injector.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
      child: TextField(
        controller: _controller,
        style: textTheme.bodyLarge,
        onChanged: (value) {
          ref.read(planetsNotifierProvider.notifier).searchPlanets(value);
        },
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: GestureDetector(
            onTap: () {
              ref.read(planetsNotifierProvider.notifier).searchPlanets(_controller.text);
            },
            child: const Icon(
              Icons.search_rounded,
            ),
          ),
          // suffixIcon: GestureDetector(
          //   onTap: () {
          //     _controller.clear();
          //     ref.read(planetsNotifierProvider.notifier).searchPlanets('');
          //   },
          //   child: const Icon(
          //     Icons.clear_rounded,
          //   ),
          // ),
          hintText: 'Search',
          hintStyle: textTheme.bodyLarge,
        ),
      ),
    );
  }
}
