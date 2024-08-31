import 'package:flutter/material.dart';
import 'package:todo_app/core/common/widgets/custom_field.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/utils/core_utils.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm(
      {super.key,
      required this.titleController,
      required this.descriptionController,
      required this.dateTimeController,
      required this.formKey});

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateTimeController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            CustomField(
              required: true,
              controller: titleController,
              hintText: context.l10n.title,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomField(
              required: true,
              controller: descriptionController,
              hintText: context.l10n.description,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomField(
              controller: dateTimeController,
              required: true,
              readOnly: true,
              hintText: context.l10n.date_time,
              onTap: () {
                CoreUtils.showDateTimePicker(context: context,callBack: (DateTime selectedDateTime) {
                  dateTimeController.text = selectedDateTime.toString();
                },);
              },
            ),
          ],
        ));
  }
}
