import 'package:flutter/material.dart';

class PillContainer extends StatelessWidget {
  final String textToShow;
  final Color? colorToShow;

  const PillContainer({super.key, required this.textToShow, this.colorToShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: colorToShow ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          textToShow,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
