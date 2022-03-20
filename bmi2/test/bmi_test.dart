import 'package:bmi/models/bmi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Metrics test', () {
    test('Bmi should be equal to 23.77', () {
      // 77 kg
      // 180 cm
      final bmi = BMI(180, 77, isUserNormal: true);
      expect(bmi.count(), equals('23.77'));
    });
    test('Bmi category should be equal to normal rage', () {
      // 77 kg
      // 180 cm
      final bmi = BMI(180, 77, isUserNormal: true);

      expect(bmi.categorise().category, equals('Normal range'));
    });
  });

  group('Imperial test', () {
    test('Bmi should be equal to 23.77', () {
      // 77 kg
      // 180 cm
      final bmi = BMI(70.8, 169.5, isUserNormal: false);
      expect(bmi.count(), equals('23.77'));
    });
    test('Bmi category should be equal to normal rage', () {
      // 77 kg
      // 180 cm
      final bmi = BMI(70.8, 169.5, isUserNormal: false);

      expect(bmi.categorise().category, equals('Normal range'));
    });
  });
}
