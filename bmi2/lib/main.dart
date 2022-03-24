import 'package:bmi/history.dart';
import 'package:bmi/info.dart';
import 'package:bmi/models/bmi.dart';
import 'package:bmi/providers/bmi_provider.dart';
import 'package:bmi/providers/providers.dart';
import 'package:bmi/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String? validator(value) {
    if (value == null ||
        value.isEmpty ||
        double.parse(value!.replaceAll(',', '.')) < 0) {
      return 'Please enter value bigger than 0';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  void handleClick(String value) {
    switch (value) {
      case 'Metrics':
        setState(() {
          isUserNormal = true;
        });
        break;
      case 'Imperial':
        setState(() {
          isUserNormal = false;
        });
        break;
      case 'Info':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InfoScreen(),
          ),
        );
        break;
      case 'History':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Hisotry(),
          ),
        );
        break;
    }
  }

  var isUserNormal = true;
  double weight = 0;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI counter'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                var units = isUserNormal ? 'Imperial' : 'Metrics';
                return {units, 'Info', 'History'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: const Key('mass_input'),
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Mass [' + (isUserNormal ? 'kg' : 'lb') + ']',
                  ),
                  keyboardType: TextInputType.number,
                  validator: validator,
                  onSaved: (value) =>
                      weight = double.parse(value!.replaceAll(',', '.')),
                ),
                TextFormField(
                  key: const Key('height_input'),
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Height [' + (isUserNormal ? 'cm' : 'in') + ']',
                  ),
                  keyboardType: TextInputType.number,
                  validator: validator,
                  onSaved: (value) =>
                      height = double.parse(value!.replaceAll(',', '.')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    key: const Key('submit'),
                    onPressed: () async {
                      final bmiRecords = ref.read(bmiListProvider.notifier);

                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(isUserNormal);
                        bmiRecords.add(height, weight, isUserNormal);
                        var instance =
                            ref.read(sharedPreferencessProvider).asData!.value!;
                        var currentList = instance.getStringList('bmi');
                        await instance.setStringList('bmi', [
                          ...currentList ?? [],
                          bmiRecords.list.last.toString()
                        ]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScoreScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text('Count BMI'),
                  ),
                ),
              ],
            )));
  }
}
