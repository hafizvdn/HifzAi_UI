import 'package:flutter/material.dart';

class DailyGoal {
  final String id;
  final String title;
  final IconData icon;
  final int targetValue;
  int currentValue;
  final String unit;

  DailyGoal({
    required this.id,
    required this.title,
    required this.icon,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
  });

  bool get isCompleted => currentValue >= targetValue;
  double get progress => currentValue / targetValue;
}