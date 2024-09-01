import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_app/src/features/tasks/domain/repos/tasks_repo.dart';

class GetTasks extends UseCaseWithStream<List<LocalTask>> {
  const GetTasks(this._tasksRepo);

  final TasksRepo _tasksRepo;

  @override
  Stream<List<LocalTask>> listen() => _tasksRepo.getTasks();

  }
