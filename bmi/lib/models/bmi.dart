import 'package:flutter/material.dart';

class BMI {
  double height;
  double weight;
  bool isUserNormal;
  BMI(this.height, this.weight, {this.isUserNormal = true});

  double count() {
    return this.weight / (this.height * this.height) * (isUserNormal ? 10000 : 703);
  }

  BmiData categorise() {
    var bmi = this.count();
    BmiData value = BmiData('error', Colors.purpleAccent);
    if (bmi < 18.49) {
      value = BmiData('Underweight', Colors.blue);
    }
    if (bmi >= 18.5 && bmi <= 24.99) {
      value = BmiData('Normal range', Colors.green);
    }
    if (bmi >= 25) {
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
