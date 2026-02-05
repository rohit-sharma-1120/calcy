import 'package:flutter/material.dart';

class CalcyButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onTap;

  const CalcyButton({
    super.key,
    required this.color,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 64, height: 64, child: Center(child: child)),
      ),
    );
  }
}
