import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  int _selectedIndex = 0;
  bool complete = false;
  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add task')),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Desc',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select date'),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Checkbox(
                      value: complete,
                      onChanged: (value) {
                        setState(() => complete = value ?? false);
                      }),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Completed')
                ],
              )
            ],
          ),
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Email',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              backgroundColor: Colors.blueAccent,
              label: 'Phone'),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined),
              backgroundColor: Colors.blueAccent,
              label: 'ToDo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room_outlined),
              backgroundColor: Colors.blueAccent,
              label: 'Meeting'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
