import 'package:flutter/material.dart';

enum ColorType { red, green, yellow, blue }

class ColorService extends ChangeNotifier {
  /// Color map for each color type
  final Map<ColorType, Color> colorMap = {
    ColorType.red: Colors.red,
    ColorType.green: Colors.green,
    ColorType.yellow: Colors.yellow,
    ColorType.blue: Colors.blue,
  };

  /// Map to store tap counts per color 
  final Map<ColorType, int> _tapCounts = {
    for (var type in ColorType.values) type: 0,
  };

  /// Public getter for tap counts
  Map<ColorType, int> get tapCounts => Map.unmodifiable(_tapCounts);

  /// Increment tap count for a specific color
  void increment(ColorType type) {
    _tapCounts[type] = (_tapCounts[type] ?? 0) + 1;
    notifyListeners(); // Notify observers of state change
  }

  /// Get tap count for a specific color
  int count(ColorType type) => _tapCounts[type] ?? 0;

  /// Get color for a specific type
  Color getColor(ColorType type) => colorMap[type] ?? Colors.grey;
}
