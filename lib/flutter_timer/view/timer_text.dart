import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_learn/flutter_timer/timer/timer_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  Color _randomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // 不透明
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(
      2,
      '0',
    );
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Container(
      color: _randomColor(), // 每次 build 生成新颜色
      alignment: Alignment.center,
      child: Text(
        '$minutesStr:$secondsStr',
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: Colors.white, // 避免背景色太深看不清
        ),
      ),
    );
  }
}
