import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:task_manager/providers.dart';
import 'package:task_manager/screens/task_add.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(child: Home()),
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
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
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTaskScreen()),
                  ),
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: todos.isNotEmpty
                ? ListView.builder(
                  itemCount: todos.length,
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
