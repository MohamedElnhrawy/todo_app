part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();
  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksError extends TasksState {
  const TasksError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class TaskAdded extends TasksState {
  const TaskAdded();
}

class FetchedTasks extends TasksState {
  const FetchedTasks(this.tasks);
  final List<LocalTask> tasks;
}
