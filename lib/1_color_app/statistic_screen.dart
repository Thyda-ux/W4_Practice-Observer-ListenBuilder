import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_service.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for changes in ColorService (Observer pattern)
    final colorService = context.watch<ColorService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: colorService.tapCounts.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Colored square indicator
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: colorService.getColor(entry.key),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Statistics text
                  Text(
                    '${entry.key.name} Taps: ${entry.value}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
