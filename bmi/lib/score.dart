import 'package:bmi/models/bmi.dart';
import 'package:flutter/material.dart';


class ScoreScreen extends StatelessWidget {
  const ScoreScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final score = ModalRoute.of(context)!.settings.arguments as BMI;
    final bmiData = score.categorise();
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(score.count().toStringAsFixed(2), style: TextStyle(color: bmiData.color),),
            Text(bmiData.category,),
          ],
        ),
      ),
    );
  }
}