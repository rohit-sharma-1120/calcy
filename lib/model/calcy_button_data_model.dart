import 'package:flutter/material.dart';

class CalcyButtonData {
  final String? label;
  final IconData? icon;
  final Color color;
  final VoidCallback onTap;

  CalcyButtonData.text(this.label, this.color, this.onTap) : icon = null;
  CalcyButtonData.icon(this.icon, this.color, this.onTap) : label = null;
}
