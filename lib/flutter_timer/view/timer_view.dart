import 'package:flutter/material.dart';

import 'package:bloc_learn/flutter_timer/view/timer_actions.dart';
import 'package:bloc_learn/flutter_timer/view/timer_text.dart';

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: Stack(
        children: [
          const Background(),
          Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 100.0),
                child: Center(child: const TimerText()),
              ),
              TimerActions(),
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.blue.shade500],
        ),
      ),
    );
  }
}
