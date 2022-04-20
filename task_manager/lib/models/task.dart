import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@immutable
class Task {
  final String id;
  final TaskType? taskType;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final bool completed;

  const Task({
    required this.taskType,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.id,
    this.completed = false,
  });

  IconData? get iconBasedOnType {
    IconData icon;
    switch (taskType) {
      case TaskType.email:
        icon = Icons.email;
        break;
      case TaskType.phone:
        icon = Icons.phone;
        break;
      case TaskType.todo:
        icon = Icons.task_alt_outlined;
        break;

      case TaskType.meeting:
        icon = Icons.meeting_room_outlined;
        break;
      default:
        icon = Icons.device_unknown;
    }
    return icon;
  }
}

class TaskList extends StateNotifier<List<Task>> {
  TaskList([List<Task>? initialTask]) : super(initialTask ?? []);

  void add(
      {String? description,
      required String title,
      DateTime? dueDate,
      TaskType? taskType,
      bool completed = false}) {
    state = [
      ...state,
      Task(
          dueDate: dueDate,
          title: title,
          taskType: taskType,
          id: _uuid.v4(),
          description: description,
          completed: completed),
    ];
  }

  void toggle(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
              id: task.id,
              completed: !task.completed,
              description: task.description,
              dueDate: task.dueDate,
              taskType: task.taskType,
              title: task.title)
        else
          task,
    ];
  }

  // void edit({required String id, required String description}) {
  //   state = [
  //     for (final task in state)
  //       if (task.id == id)
  //         Task(
  //           id: task.id,
  //           completed: task.completed,
  //           description: description,
  //         )
  //       else
  //         task,
  //   ];
  // }

  void remove(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }
}

enum TaskType { todo, email, phone, meeting }
