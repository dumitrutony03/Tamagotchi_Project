import 'package:flutter/material.dart';

class Tamagotchi extends StatelessWidget {
  final double? HealthPercentage;
  final double? HappinessPercentage;

  Tamagotchi({
    required this.HealthPercentage,
    required this.HappinessPercentage,
  });

  Map<String, dynamic> toJson() => {
        'healthPercentage': HealthPercentage,
        'happinessPercentage': HappinessPercentage,
      };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
