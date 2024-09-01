import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/common/views/loader.dart';
import 'package:todo_app/core/common/widgets/app_bar.dart';
import 'package:todo_app/core/common/widgets/gradient_background.dart';
import 'package:todo_app/core/common/widgets/rounded_button.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_app/src/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/src/features/tasks/presentation/widgets/add_task_form.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const routeName = '/add-task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: context.l10n.add_task),
      body: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksError) {
            CoreUtils.showSnakeBar(context, state.message);
          } else if (state is TaskAdded) {
            CoreUtils.showSnakeBar(context, context.l10n.task_added_success);
            titleController.text = '';
            descriptionController.text = '';
            dateTimeController.text = '';
          }
        },
        builder: (context, state) {
          return GradientBackground(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                   SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(
                      MediaRes.startAddingLottie,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  AddTaskForm(
                    titleController: titleController,
                    descriptionController: descriptionController,
                    dateTimeController: dateTimeController,
                    formKey: formKey,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  state is TasksLoading
                      ? const Center(child: Loader())
                      : RoundedButton(
                          label: context.l10n.submit,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              final task = LocalTask.empty().copyWith(
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                createdAt:
                                DateTime.parse(dateTimeController.text.trim()),
                                updatedAt:
                                DateTime.parse(dateTimeController.text.trim()),
                                id: const Uuid().v4()
                              );
                              context.read<TasksBloc>().add(AddTaskEvent(task));
                            }
                          },
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
