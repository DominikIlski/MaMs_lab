import 'package:flutter/material.dart';

class BMI {
  double height;
  double weight;
  bool isUserNormal;
  BMI(this.height, this.weight, {this.isUserNormal = true});

  String count() {
    var score = this.weight /
        (this.height * this.height) *
        (isUserNormal ? 10000 : 703);
    return score.toStringAsFixed(2);
  }

  BmiData categorise() {
    var bmi = this.count();
    BmiData value = BmiData('error', Colors.purpleAccent);
    if (double.parse(bmi) < 18.49) {
      value = BmiData('Underweight', Colors.blue);
    }
    if (double.parse(bmi) >= 18.5 && double.parse(bmi) <= 24.99) {
      value = BmiData('Normal range', Colors.green);
    }
    if (double.parse(bmi) >= 25) {
      value = BmiData('Overweight', Colors.red);
    }
    return value;
  }
}

class BmiData {
  final String category;
  final Color color;

  BmiData(this.category, this.color);
}
