import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_app/src/features/tasks/domain/repos/tasks_repo.dart';

class AddTask extends UseCaseWithParams<void,LocalTask>{
  const AddTask(this._tasksRepo);

  final TasksRepo _tasksRepo;

  @override
  ResultFuture<void> call(LocalTask params) => _tasksRepo.addTask(params);
}