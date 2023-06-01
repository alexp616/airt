import 'package:flutter/material.dart';
import 'package:airt/pages/home.dart';

void main() => runApp(const AIrt());

class AIrt extends StatelessWidget {
  const AIrt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIrt',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 252, 250, 238),
          secondary: Color.fromARGB(255, 130, 182, 182),
          background: Color.fromARGB(255, 31, 32, 36),
          tertiary: Color.fromARGB(255, 253, 138, 138)
        ),
        textTheme: const TextTheme().apply(
          fontFamily: 'Poppins',
          bodyColor: const Color.fromARGB(255, 255, 253, 237),
        )
      ),
      home: const HomePage()
    );
  }
}