import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_service.dart';

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for changes in ColorService (Observer pattern)
    final colorService = context.watch<ColorService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: ColorType.values.map((type) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorService.getColor(type),
                  minimumSize: const Size.fromHeight(80),
                ),
                onPressed: () => colorService.increment(type),
                child: Text(
                  '${type.name} Taps: ${colorService.count(type)}',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
