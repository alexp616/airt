import 'package:flutter/material.dart';
import 'dart:math';

class CustomAppBar extends AppBar {
  final BuildContext context;

  CustomAppBar({
    super.key,
    required this.context,
  }) : super(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.background,
    title: Center(
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 750),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                IconData(
                  0xf572,
                  fontFamily: 'MaterialIcons'
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AI',
                  style:
                      Theme.of(context).textTheme.headlineLarge!.apply(
                    fontWeightDelta: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  'rt',
                  style:
                      Theme.of(context).textTheme.headlineLarge!.apply(
                    fontWeightDelta: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  '.',
                  style:
                      Theme.of(context).textTheme.headlineLarge!.apply(
                    fontWeightDelta: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const Icon(
              IconData(
                0xf053e,
                fontFamily: 'MaterialIcons'
              ),
            ),
          ],
        ),
      ),
    ),
  );
}