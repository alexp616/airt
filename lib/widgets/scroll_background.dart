import 'package:flutter/material.dart';

class ScrollBackground extends StatefulWidget {
  const ScrollBackground({super.key});

  @override
  ScrollBackgroundState createState() => 
    ScrollBackgroundState();
}

class ScrollBackgroundState extends State<ScrollBackground>
  with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  double _backgroundPosition = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 90),
      vsync: this,
    )..repeat();

    _animationController.addListener(() {
      setState(() {
        _backgroundPosition = _animationController.value
          * MediaQuery.of(context).size.height * 2;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -1 * _backgroundPosition,
          child: Image.asset(
            'background.png',
            height: 2 * MediaQuery.of(context).size.height,
            fit: BoxFit.cover
          )
        ),
        Positioned(
          top: -1 * _backgroundPosition + (MediaQuery.of(context).size.height * 2),
          child: Image.asset(
            'background.png',
            height: 2 * MediaQuery.of(context).size.height,
            fit: BoxFit.cover
          )
        )
      ],
    );
  }
}