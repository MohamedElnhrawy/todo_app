import 'package:async/async.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/src/features/tasks/data/models/task.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';

abstract class LocalTasksDataSource {
  const LocalTasksDataSource();

  Future<void> addTask(LocalTask task);

  Stream<List<LocalTask>> getTasks();
  Future<void> deleteTask(String taskID);
  Future<void> deleteAllTasks();
  Future<void> updateTask(LocalTask task);
}

class LocalTasksDataSourceImpl implements LocalTasksDataSource {
  const LocalTasksDataSourceImpl({required this.box});

  final Box<TaskModel> box;

  @override
  Future<void> addTask(LocalTask task) async {
    try {
      final taskModel = task.toTaskModel();
      await box.put(task.id, taskModel);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Stream<List<LocalTask>> getTasks() {
    try {
      final initialTasksStream =
          Stream.value(box.values.map((model) => model.toLocalTask()).toList());

      final changesStream = box
          .watch()
          .map((_) => box.values.map((model) => model.toLocalTask()).toList());

      return StreamGroup.merge([initialTasksStream, changesStream]);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }


  @override
  Future<void> updateTask(LocalTask task) async {
    try {

      if (box.containsKey(task.id)) {
        await box.put(task.id, task.toTaskModel());
      } else {
        throw const CacheException(message: "Task not found");
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTask(String taskID) async {
    try {

      if (box.containsKey(taskID)) {
        await box.delete(taskID);
      } else {
        throw const CacheException(message: "Task not found");
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    try {
        await box.clear();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

}
