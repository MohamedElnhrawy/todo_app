import 'package:dartz/dartz.dart';
import 'package:todo_app/core/errors/exceptions.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/tasks/data/datesources/local_tasks_data_source.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_app/src/features/tasks/domain/repos/tasks_repo.dart';

class TasksRepoImpl implements TasksRepo {
  const TasksRepoImpl({required LocalTasksDataSource dataSource})
      : _dataSource = dataSource;

  final LocalTasksDataSource _dataSource;

  @override
  VoidFuture addTask(LocalTask task) async {
    try {
      await _dataSource.addTask(task);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  Stream<List<LocalTask>> getTasks()  {
    try {
      return  _dataSource.getTasks();
    } on CacheException catch (e) {
      throw CacheFailure.fromException(e);
    }
  }

  @override
  VoidFuture deleteAllTasks() async{
    try {
        await _dataSource.deleteAllTasks();
        return const Right(null);
    } on CacheException catch (e) {
      throw CacheFailure.fromException(e);
    }
  }

  @override
  VoidFuture deleteTask(int taskID)async {
    try {
        await  _dataSource.deleteTask(taskID);
        return const Right(null);
    } on CacheException catch (e) {
      throw CacheFailure.fromException(e);
    }
  }

  @override
  VoidFuture updateTask(LocalTask task) async{
    try {
        await _dataSource.updateTask(task);
        return const Right(null);
    } on CacheException catch (e) {
      throw CacheFailure.fromException(e);
    }
  }
}
