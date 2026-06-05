import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FloatingParticles extends StatelessWidget {
  const FloatingParticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(15, (index) {
        final random = Random();
        return Positioned(
          top: random.nextDouble() * MediaQuery.of(context).size.height,
          left: random.nextDouble() * MediaQuery.of(context).size.width,
          child: Container(
            width: 2 + random.nextDouble() * 4,
            height: 2 + random.nextDouble() * 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .move(
                duration: (5 + random.nextInt(5)).seconds,
                begin: const Offset(0, 0),
                end: Offset(random.nextDouble() * 50, random.nextDouble() * 50),
                curve: Curves.easeInOut,
              )
              .then()
              .move(
                duration: (5 + random.nextInt(5)).seconds,
                begin:
                    Offset(random.nextDouble() * 50, random.nextDouble() * 50),
                end: const Offset(0, 0),
                curve: Curves.easeInOut,
              ),
        );
      }),
    );
  }
}
