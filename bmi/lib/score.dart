import 'package:flutter/material.dart';


class Score extends StatelessWidget {
  const Score({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final score = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: Center(child: Text(score.toString())),
    );
  }
}