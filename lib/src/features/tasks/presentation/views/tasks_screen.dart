import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/common/widgets/app_bar.dart';
import 'package:todo_app/core/common/widgets/gradient_background.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/src/features/tasks/presentation/widgets/task_tile.dart';
import 'package:workmanager/workmanager.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<LocalTask>? tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: context.l10n.tasks,
        action1Widget: IconButton(
          iconSize: 35,
          color: Colours.primaryColor,
          icon: const Icon(IconlyLight.delete),
          onPressed: () {
            if (tasks != null && tasks!.isNotEmpty) {
              CoreUtils.showCustomDialog(
                  context: context,
                  title: context.l10n.warning,
                  message: context.l10n.clear_all_tasks_message,
                  action1Title: context.l10n.cancel,
                  action2Title: context.l10n.ok,
                  action2: () async {
                    Navigator.of(context).pop();
                    context.read<TasksBloc>().add(const DeleteAllTasksEvent());
                  });
            }
          },
        ),
      ),
      body: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksError) {
            CoreUtils.showSnakeBar(context, state.message);
          } else if (state is FetchedTasks) {
            setupWorkManager();
          }
        },
        builder: (BuildContext context, TasksState state) {
          return StreamBuilder<List<LocalTask>>(
            stream: context.read<TasksBloc>().tasksSubscription,
            builder: (context, snapshot) {
              tasks = snapshot.data
                ?..sort((a, b) => b.createdAt.compareTo(a.createdAt));

              if (tasks != null) {
                context.read<TasksBloc>().add(TasksFetchedEvent(tasks!));
              }

              return GradientBackground(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: (tasks != null && tasks!.isNotEmpty)
                      ? ListView.builder(
                          itemCount: tasks!.length,
                          itemBuilder: (_, index) {
                            final task = tasks![index];
                            return TaskTile(
                              task: task,
                              onCheckChange: (task) {
                                final updatedTask = task.copyWith(
                                    isCompleted: !task.isCompleted);
                                context
                                    .read<TasksBloc>()
                                    .add(UpdateTaskEvent(updatedTask));
                              },
                              onDeleteTask: (task) {
                                CoreUtils.showCustomDialog(
                                    context: context,
                                    title: context.l10n.warning,
                                    message:
                                        '${context.l10n.clear_one_tasks_message} ${task.title}',
                                    action1Title: context.l10n.cancel,
                                    action2Title: context.l10n.ok,
                                    action2: () async {
                                      Navigator.of(context).pop();
                                      context.read<TasksBloc>().add(
                                          DeleteTaskEvent(task.id));
                                    });
                              },
                            );
                          })
                      : Center(
                          child: Lottie.asset(
                            MediaRes.startAddingLottie,
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void setupWorkManager() {
    Workmanager().registerPeriodicTask(
      AppConstants.taskID,
      AppConstants.taskName,
      existingWorkPolicy: ExistingWorkPolicy.append,
      inputData: {},
      constraints: Constraints(
          networkType: NetworkType.connected, requiresStorageNotLow: false),
      frequency: const Duration(minutes: 2),
      initialDelay: const Duration(minutes: 1), // Delay for 10 seconds
    );
  }
}
