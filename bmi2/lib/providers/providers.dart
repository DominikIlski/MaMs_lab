import 'dart:math';

import 'package:bmi/models/bmi.dart';
import 'package:bmi/providers/bmi_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencessProvider =
    FutureProvider<SharedPreferences?>((ref) async {
  return (await SharedPreferences.getInstance());
});
final bmiListProvider = StateNotifierProvider<BmiRecords, List<BMI>>((ref) {
  final prefs = ref.watch(sharedPreferencessProvider);
  if (prefs.asData == null) return BmiRecords([]);
  var list = prefs.asData!.value!.getStringList('bmi') ?? [];
  var history = list
      .map((e) {
        var data = BMI.toListString(e);
        return BMI(data[0],
            height: double.parse(data[1]),
            weight: double.parse(data[2]),
            isUserNormal: 'true' == data[3]);
      })
      .toList()
      .sublist(max(list.length - 10, 0), list.length);
  return BmiRecords(history);
});
