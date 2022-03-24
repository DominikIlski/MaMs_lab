import 'dart:math';

import 'package:bmi/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Hisotry extends ConsumerWidget {
  const Hisotry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var bmis = ref.watch(bmiListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Hisotry')),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            ...bmis
                .map((e) => Card(
                  
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        
                          '${e.count()}  ${e.categorise().category} \n metrics: ${e.isUserNormal}'),
                    )))
                .toList()
                .sublist(max(bmis.length - 10, 0), bmis.length)
          ]),
        ),
      ),
    );
  }
}
