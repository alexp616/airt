import 'package:flutter/material.dart';
import 'package:airt/widgets/scroll_background.dart';
import 'package:airt/widgets/login_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            const ScrollBackground(),
            Positioned.fill(
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  'vignette.png',
                  fit: BoxFit.fill
                )
              )
            ),
            const Center(
              child: LoginCard()
            )
          ],
        )
      )
    );
  }
}