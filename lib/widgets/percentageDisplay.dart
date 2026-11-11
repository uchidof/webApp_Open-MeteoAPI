import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PercentageDisplay extends StatelessWidget {
  final int percentage;

  const PercentageDisplay({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(20, (index) {
        final isActive = index < (percentage / 5).ceil();

        return Expanded(
          child: Container(
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
          ),
        );
      }),
    );
  }
}
