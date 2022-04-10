import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/task.dart';

final todoListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) {
  return TaskList(const []);
});