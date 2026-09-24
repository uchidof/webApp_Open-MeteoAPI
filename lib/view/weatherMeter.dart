import 'package:flutter/material.dart';

class WeatherMeter extends StatelessWidget {
  final IconData icon;
  final int level;

  const WeatherMeter({required this.icon, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final isActive = index >= 3 - level; //Direcao VERTICAL do medidor

            return Container(
              width: 40,
              height: 35,
              margin: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(4),
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
              ),
            );
          }),
        ),

        const SizedBox(height: 8),

        Icon(icon, size: 32),
      ],
    );
  }
}
