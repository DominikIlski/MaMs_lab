import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'models/task.dart';

final todoListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) {
  return TaskList(const []);
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(child: Home()),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  // void handleClick(String value) {
  //   switch (value) {
  //     case 'Metrics':
  //       setState(() {
  //         isUserNormal = true;
  //       });
  //       break;
  //     case 'Imperial':
  //       setState(() {
  //         isUserNormal = false;
  //       });
  //       break;
  //     case 'Info':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const InfoScreen(),
  //         ),
  //       );
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: <Widget>[
          GestureDetector(
            child: const Icon(
              Icons.add,
            ),
            onTap: () => print('test'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: todos.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (ctx, index) => Text(todos[index].title))
                : const Center(
                    child: Text('There are no tasks yet'),
                  ),
          )
        ],
      ),
    );
  }
}


