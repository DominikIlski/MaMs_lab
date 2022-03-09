import 'package:flutter/material.dart';

class BMI {
  int height;
  int weight;
  bool isUserNormal;
  BMI(this.height, this.weight, {this.isUserNormal = true});

  double count() {
    return this.height / (this.weight * this.weight) * (isUserNormal ? 1 : 703);
  }

  BmiData categorise() {
    var bmi = this.count();
    BmiData value;
    if (bmi < 18.49) {
      value = BmiData('Underweight', Colors.blue);
    }
    if (bmi >= 18.5 && bmi <= 24.99) {
      value = BmiData('Normal range', Colors.green);
    } else {
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
