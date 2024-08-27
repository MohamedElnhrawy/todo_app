import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/context_extension.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
