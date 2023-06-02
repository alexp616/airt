import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final Color color;
  final String label;
  final int iconId;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.label,
    required this.iconId
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Column(
        children: [
          Icon(
            IconData(iconId, fontFamily: 'MaterialIcons'),
            size: 100,
            color: color,
            shadows: const [
              Shadow(
                offset: Offset(4.0, 6.0),
                blurRadius: 4.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 0.01 * MediaQuery.of(context).size.height,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: color,
                fontWeightDelta: -3,
                shadows: const [
                  Shadow(
                    offset: Offset(4.0, 6.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      label: const Text(''),
    );
  }
}
