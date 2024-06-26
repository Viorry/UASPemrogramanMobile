import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingUtil extends StatelessWidget {
  const LoadingUtil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xff02968A),
            size: 100,
            secondRingColor: const Color(0xff1B8854),
            thirdRingColor: Colors.purple),
      ),
    );
  }
}
