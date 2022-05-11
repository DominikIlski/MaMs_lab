import 'package:flutter/material.dart';
import 'package:ml_app/screens/camera_screen.dart';
import 'package:ml_app/screens/object_reco_screen.dart';
import 'package:ml_app/screens/text_reco_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _screens = <Widget>[
    CameraScreen(),
    TextRecoScreen(),
    ObjectRecoScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ml app'),
        ),
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Labeling'),
            BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Text reco'),
            BottomNavigationBarItem(icon: Icon(Icons.data_object), label: 'Object'),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
