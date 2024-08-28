import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/common/widgets/gradient_background.dart';
import 'package:todo_app/core/res/media_res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: Lottie.asset(
          MediaRes.pageUnderConstruction,
        ),
      ),
    );
  }
}
