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
                    itemBuilder: (ctx, index) => Dismissible(
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              /// edit item
                              return true;
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              ref
                                  .read(todoListProvider.notifier)
                                  .toggle(todos[index].id);
                              return false;
                            }
                          },
                          key: Key(todos[index].id),
                          secondaryBackground: Container(
                            width: 50,
                            alignment: Alignment.centerRight,
                            color: Colors.green,
                            child: const Icon(Icons.check),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          background: Container(
                            width: 50,
                            alignment: Alignment.centerLeft,
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(todos[index].title),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(todos[index].description ??
                                                  ''),
                                            ],
                                          ),
                                        ),
                                        if (todos[index].dueDate != null)
                                          Text(
                                              '${todos[index].dueDate!.day}-${todos[index].dueDate!.month}-${todos[index].dueDate!.year}'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(todos[index].iconBasedOnType),
                                        Checkbox(
                                            value: todos[index].completed,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                            onChanged: null)
                                      ])),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                          onDismissed: (direction) {
                            ref
                                .read(todoListProvider.notifier)
                                .remove(todos[index]);
                          },
                        ))
                : const Center(
                    child: Text('There are no tasks yet'),
                  ),
          )
        ],
      ),
    );
  }
}
