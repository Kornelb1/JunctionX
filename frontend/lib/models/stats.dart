import 'dart:core';

class Stats {
  final double water;
  final double trees;
  final double energy;
  final double plastic;
  final double co2;

  Stats({
    this.water = 0,
    this.trees = 0,
    this.energy = 0,
    this.plastic = 0,
    this.co2 = 0,
  });

  factory Stats.fromJson(Map<String, dynamic> responseData) {
    return Stats(
        // token: responseData['token'],
        water: responseData['total_water'],
        trees: responseData['total_trees'],
        energy: responseData['total_energy'],
        plastic: responseData['total_plastic'],
        co2: responseData['total_emissions']);
  }
}
