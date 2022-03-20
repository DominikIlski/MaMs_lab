import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
        const Text('Dominik Ilski'),
        const Text('243449'),
      ]),),
    );
  }
}