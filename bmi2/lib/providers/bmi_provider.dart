import 'package:bmi/models/bmi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final bmiProvider = Provider((ref) => BmiRecords());

class BmiRecords extends StateNotifier<List<BMI>> {
  BmiRecords([List<BMI>? initialBMI]) : super(initialBMI ?? []);

  void add(double height, double weight, bool isUserNormal) {
    state = [...state, BMI(_uuid.v4(), height: height, weight: weight)];
  }
}
