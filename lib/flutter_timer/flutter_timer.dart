import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_learn/flutter_timer/ticker.dart';
import 'package:bloc_learn/flutter_timer/timer/timer_bloc.dart';
import 'package:bloc_learn/flutter_timer/view/timer_view.dart';

class FlutterTimer extends StatelessWidget {
  const FlutterTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: Ticker()),
      child: const TimerView(),
    );
  }
}
