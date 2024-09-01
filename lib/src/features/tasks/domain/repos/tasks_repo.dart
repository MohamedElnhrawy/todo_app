import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';

abstract class TasksRepo {
  const TasksRepo();

  Stream<List<LocalTask>> getTasks();
  VoidFuture addTask(LocalTask task);
  VoidFuture deleteTask(String taskID);
  VoidFuture deleteAllTasks();
  VoidFuture updateTask(LocalTask task);
}