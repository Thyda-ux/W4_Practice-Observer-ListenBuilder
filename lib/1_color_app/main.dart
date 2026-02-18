import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_service.dart';
import 'home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ColorService(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Taps App',
      home: const HomeScreen(), 
    );
  }
}
