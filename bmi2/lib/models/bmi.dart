import 'package:flutter/material.dart';
 
@immutable
class BMI {
  final String id;
  final double height;
  final double weight;
  final bool isUserNormal;
  const BMI(this.id,
      {required this.height, required  this.weight, this.isUserNormal = true});

  String count() {
    var score = weight /
        (height * height) *
        (isUserNormal ? 10000 : 703);
    return score.toStringAsFixed(2);
  }

  BmiData categorise() {
    var bmi = count();
    BmiData value = const BmiData('error', Colors.purpleAccent);
    if (double.parse(bmi) < 18.49) {
      value = const BmiData('Underweight', Colors.blue);
    }
    if (double.parse(bmi) >= 18.5 && double.parse(bmi) <= 24.99) {
      value = const BmiData('Normal range', Colors.green);
    }
    if (double.parse(bmi) >= 25) {
      value = const BmiData('Overweight', Colors.red);
    }
    return value;
  }
  static List<String> toListString(String string) {
    return string.split(',');
  }
  @override
  String toString() => '$id,$height,$weight,$isUserNormal';
  
}

@immutable
class BmiData {
  final String category;
  final Color color;

  const BmiData(this.category, this.color);
}
