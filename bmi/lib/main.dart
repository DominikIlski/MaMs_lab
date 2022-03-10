import 'package:bmi/info.dart';
import 'package:bmi/models/bmi.dart';
import 'package:bmi/score.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    }
  }

  var isUserNormal = true;
  double weight = 77;
  double height = 180;
  BMI? score;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI counter'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                var value = isUserNormal ? 'Imperial' : 'Metrics';
                return {value, 'Info'}.map((String choice) {
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
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mass [' + (isUserNormal ? 'kg' : 'lb') + ']',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 0) {
                      return 'Please enter value bigger than 0';
                    }
                    return null;
                  },
                  onSaved: (value) => weight = double.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Height [' + (isUserNormal ? 'cm' : 'in') + ']',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 0) {
                      return 'Please enter value bigger than 0';
                    }
                    return null;
                  },
                  onSaved: (value) => height = double.parse(value!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        score = BMI(height, weight, isUserNormal: isUserNormal);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScoreScreen(),
                            settings: RouteSettings(arguments: score),
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