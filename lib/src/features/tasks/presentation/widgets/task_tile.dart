import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/fonts.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    required this.onCheckChange,
    required this.onDeleteTask,
    super.key,
  });

  final LocalTask task;
  final void Function(LocalTask) onCheckChange;
  final void Function(LocalTask) onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: task.isCompleted
                ? Colours.primaryColor.withOpacity(.5)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 5),
                blurRadius: 8,
              )
            ]),
        child: GestureDetector(
          onTap: () => onCheckChange(task),
          child: ListTile(
              leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => onCheckChange(task),
                  checkColor: Colors.white,
                  activeColor: Colours.primaryColor),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        color: task.isCompleted ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: Colors.white,
                        decorationThickness: 2.0,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                  IconButton(
                      iconSize: 30,
                      onPressed: () => onDeleteTask(task),
                      icon: const Icon(
                        IconlyLight.delete,
                        color: Colors.black,
                      ))
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.description ?? '',
                    style: TextStyle(
                      color: task.isCompleted ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: Fonts.aeonik,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.white,
                      decorationThickness: 2.0,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                  Align(
                    alignment: context.isAR
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('hh:mm a').format(task.createdAt),
                            style: TextStyle(
                                fontSize: 14,
                                color: task.isCompleted
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          Text(
                            DateFormat.yMMMEd().format(task.createdAt),
                            style: TextStyle(
                                fontSize: 12,
                                color: task.isCompleted
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
