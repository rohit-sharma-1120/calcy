import 'package:flutter/material.dart';

class CalcyButton extends StatelessWidget {
  const CalcyButton({
    super.key,
    this.child,
    this.onTap,
    required this.color,
  });
  final Widget? child;
  final Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        minRadius: 22,
        maxRadius: 38,
        backgroundColor: color,
        child: child,
      ),
    );
  }
}
