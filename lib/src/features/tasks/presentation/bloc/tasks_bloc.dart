import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_app/src/features/tasks/domain/usecases/add_task.dart';
import 'package:todo_app/src/features/tasks/domain/usecases/delete_all_tasks.dart';
import 'package:todo_app/src/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app/src/features/tasks/domain/usecases/get_tasks.dart';
import 'package:todo_app/src/features/tasks/domain/usecases/update_task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({
    required AddTask addTask,
    required GetTasks getTasks,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
    required DeleteAllTasks deleteAllTasks,
  })  : _addTask = addTask,
        _getTasks = getTasks,
        _deleteTask = deleteTask,
        _updateTask = updateTask,
        _deleteAllTasks = deleteAllTasks,
        super(const TasksInitial()) {
    on<TasksEvent>((event, emit) {
      emit(const TasksLoading());
    });

    on<AddTaskEvent>(_addTaskHandler);
    on<UpdateTaskEvent>(_updateTaskHandler);
    on<DeleteTaskEvent>(_deleteTaskHandler);
    on<DeleteAllTasksEvent>(_deleteAllTasksHandler);
    on<TasksFetchedEvent>(_fetchedTaskHandler);
    tasksSubscription = _getTasks.listen();
  }

  final AddTask _addTask;
  final GetTasks _getTasks;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final DeleteAllTasks _deleteAllTasks;

  Stream<List<LocalTask>> tasksSubscription = const Stream.empty();

  Future<void> _addTaskHandler(
      AddTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _addTask.call(event.task);
    result.fold(
      (fail) => emit(TasksError(fail.errorMessage)),
      (_) => emit(const TaskAdded()),
    );
  }


  Future<void> _updateTaskHandler(
      UpdateTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _updateTask.call(event.task);
    result.fold(
      (fail) => emit(TasksError(fail.errorMessage)),
      (_) => emit(const TaskAdded()),
    );
  }

  Future<void> _deleteTaskHandler(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _deleteTask.call(event.taskID);
    result.fold(
      (fail) => emit(TasksError(fail.errorMessage)),
      (_) => emit(const TaskAdded()),
    );
  }

  Future<void> _fetchedTaskHandler(
      TasksFetchedEvent event, Emitter<TasksState> emit) async {
    emit(FetchedTasks(event.tasks));
  }

  Future<void> _deleteAllTasksHandler(
      DeleteAllTasksEvent event, Emitter<TasksState> emit) async {
    final result = await _deleteAllTasks.call();
    result.fold(
      (fail) => emit(TasksError(fail.errorMessage)),
      (_) => emit(const TaskAdded()),
    );
  }
}
