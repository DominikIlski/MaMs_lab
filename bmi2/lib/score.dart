import 'package:bmi/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/bmi.dart';

class ScoreScreen extends ConsumerWidget {
  const ScoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scores = ref.watch(bmiListProvider);
    BMI? score;
    BmiData? bmiData;
    if (scores.isNotEmpty) {
      score = scores.last;
      bmiData = score.categorise();
    }
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              score?.count() ?? 'error',
              key: const Key('score'),
              style: TextStyle(color: bmiData?.color ?? Colors.black),
            ),
            Text(
              bmiData?.category ?? 'error, pleas try again',
            ),
          ],
        ),
      ),
    );
  }
}
