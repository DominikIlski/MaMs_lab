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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var isUserNormal = true;
  var score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mass [' + (isUserNormal ? 'kg' : 'fn') + ']',
                  ),
                  keyboardType: TextInputType.number,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 0) {
                      return 'Please enter value bigger than 0';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mass [' + (isUserNormal ? 'cm' : 'foot') + ']',
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                       
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Score(),
                            // Pass the arguments as part of the RouteSettings. The
                            // DetailScreen reads the arguments from these settings.
                            settings: RouteSettings(arguments: score),
                          ),
                        );
                      }
                    },
                    child: const Text('Policz'),
                  ),
                ),
              ],
            )));
  }
}
