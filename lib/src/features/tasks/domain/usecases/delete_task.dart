import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/tasks/domain/repos/tasks_repo.dart';

class DeleteTask extends UseCaseWithParams<void,String>{
  const DeleteTask(this._tasksRepo);

  final TasksRepo _tasksRepo;

  @override
  ResultFuture<void> call(String params) => _tasksRepo.deleteTask(params);


}