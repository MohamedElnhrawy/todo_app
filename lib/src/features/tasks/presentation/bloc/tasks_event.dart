part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TasksEvent {
  const AddTaskEvent(this.task);
  final LocalTask task;

  @override
  List<Object?> get props => [task.id];
}


class UpdateTaskEvent extends TasksEvent {
  const UpdateTaskEvent(this.task);
  final LocalTask task;

  @override
  List<Object?> get props => [task.id];
}
class DeleteTaskEvent extends TasksEvent {
  const DeleteTaskEvent(this.taskID);
  final String taskID;

  @override
  List<Object?> get props => [taskID];
}
class DeleteAllTasksEvent extends TasksEvent {
  const DeleteAllTasksEvent();

}

class TasksFetchedEvent extends TasksEvent {
  const TasksFetchedEvent(this.tasks);
  final List<LocalTask> tasks;

}
