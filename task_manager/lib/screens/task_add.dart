import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add task')),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderChoiceChip(
                        initialValue: TaskType.email,
                        autovalidateMode: AutovalidateMode.always,
                        validator: FormBuilderValidators.required(
                            errorText:
                                'There should be at least one selected.'),
                        name: 'type',
                        runSpacing: 5,
                        selectedColor: Colors.blueAccent,
                        backgroundColor: Colors.transparent,
                        alignment: WrapAlignment.spaceEvenly,
                        options: const [
                          FormBuilderFieldOption(
                            value: TaskType.email,
                            child: Icon(Icons.email),
                          ),
                          FormBuilderFieldOption(
                            value: TaskType.phone,
                            child: Icon(Icons.phone),
                          ),
                          FormBuilderFieldOption(
                            value: TaskType.todo,
                            child: Icon(Icons.task_alt_outlined),
                          ),
                          FormBuilderFieldOption(
                            value: TaskType.meeting,
                            child: Icon(Icons.meeting_room_outlined),
                          ),
                        ]),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'title',
                      decoration: const InputDecoration(
                        labelText: 'title',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                        name: 'desc',
                        decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder())),
                    const SizedBox(height: 20),
                    FormBuilderDateTimePicker(
                        name: 'date',
                        initialValue: DateTime.now(),
                        inputType: InputType.date),
                    const SizedBox(height: 20),
                    FormBuilderCheckbox(
                        name: 'completed', title: const Text('Completed')),
                    ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState?.validate() ?? false) {
                            var value = _formKey.currentState!.value;
                            ref.read(todoListProvider.notifier).add(
                                title: value['title'],
                                description: value['desc'],
                                dueDate: value['date'],
                                taskType: value['type']);
                            _formKey.currentState!.reset();
                          } else {}
                        },
                        child: const Text('Submit'))
                  ],
                ),
              ))),
    );
  }
}
