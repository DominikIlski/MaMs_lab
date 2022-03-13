import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:bmi/main.dart' as app;

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding;
  testWidgets('Input and score check', (WidgetTester tester) async {

    app.main();

   
    await binding.traceAction(() async {

      await tester.pumpAndSettle();
      var mass = find.byKey(Key('mass_input'));
     
      await tester.enterText(mass, '77');
      //verify if value was inserted
      expect(find.text('77'), findsOneWidget);
      var height = find.byKey(Key('height_input'));
      //verify if value was inserted

      await tester.enterText(height, '180');
      expect(find.text('180'), findsOneWidget);
      expect(find.text('181'), findsNothing);
      
      await tester.tap(find.byKey(Key('submit')));
      await tester.pumpAndSettle();
      var score = find.byKey(const Key('score'));
      expect((tester.widget(score) as Text).data, equals('23.77'));

    });
  });
}
