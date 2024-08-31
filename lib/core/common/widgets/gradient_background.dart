import 'package:flutter/material.dart';
import 'package:todo_app/core/res/colours.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, this.image, required this.child,this.padding});
  final String? image;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: padding,
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: image == null ? null: DecorationImage(
              image: AssetImage(image!),
              fit: BoxFit.cover

          ),

          gradient: image == null ?
           const LinearGradient(
              colors:
                Colours.gradient
              ,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight

          ) : null,
        ),
        child: SafeArea(
          child: Center(
            child: child,
          ),
        ),
    );
  }
}
