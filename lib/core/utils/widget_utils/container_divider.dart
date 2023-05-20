import 'package:flutter/material.dart';

class ContainerDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double height;

  const ContainerDivider({
    super.key,
    this.color = Colors.black26,
    this.thickness = 1,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: thickness,
      height: height,
      color: color,
    );
  }
}
