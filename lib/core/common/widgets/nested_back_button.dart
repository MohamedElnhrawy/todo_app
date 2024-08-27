import 'package:flutter/material.dart';
import 'package:todo_app/core/extensions/context_extension.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        child: IconButton(
      onPressed: (){
        try{
          context.pop();
        }catch(_){
          Navigator.of(context).pop();
        }
      },
      icon: context.theme.platform == TargetPlatform.iOS ? const Icon(Icons.arrow_back_ios_new) : const Icon(Icons.arrow_back),
    ), onPopInvoked: (_) async {

      try{
        context.pop();
      }catch(_){
        Navigator.of(context).pop();
      }
    });
  }
}
