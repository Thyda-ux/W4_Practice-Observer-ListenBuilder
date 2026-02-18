import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TapModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

enum CardType { red, blue }

class TapModel extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;

  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;

  void incrementRed() {
    _redTapCount++;
    notifyListeners();
  }

  void incrementBlue() {
    _blueTapCount++;
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Color Taps' : 'Statistics',
        ),
      ),
      body: _currentIndex == 0
          ? const ColorTapsScreen()
          : const StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<TapModel, int>(
          selector: (_, model) => model.redTapCount,
          builder: (_, redCount, __) {
            return ColorTap(
              type: CardType.red,
              tapCount: redCount,
              onTap: () => context.read<TapModel>().incrementRed(),
            );
          },
        ),
        Selector<TapModel, int>(
          selector: (_, model) => model.blueTapCount,
          builder: (_, blueCount, __) {
            return ColorTap(
              type: CardType.blue,
              tapCount: blueCount,
              onTap: () => context.read<TapModel>().incrementBlue(),
            );
          },
        ),
      ],
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor =>
      type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Selector<TapModel, (int, int)>(
        selector: (_, model) =>
            (model.redTapCount, model.blueTapCount),
        builder: (_, counts, __) {
          final red = counts.$1;
          final blue = counts.$2;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Red Taps: $red',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text(
                'Blue Taps: $blue',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          );
        },
      ),
    );
  }
}
