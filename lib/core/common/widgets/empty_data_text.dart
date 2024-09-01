import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/context_extension.dart';

class EmptyDataText extends StatelessWidget {
  const EmptyDataText(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
