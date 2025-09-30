import 'package:bloc_learn/flutter_timer/timer/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      // 上一个 state 的运行时类型 和 当前 state 的运行时类型 不同，才重新构建 UI
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                FloatingActionButton(
                  heroTag: "start",
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<TimerBloc>().add(
                    TimerStarted(duration: state.duration),
                  ),
                ),
              ],
              TimerRunInProgress() => [
                FloatingActionButton(
                  heroTag: "pause",
                  child: const Icon(Icons.pause),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerPaused()),
                ),
                FloatingActionButton(
                  heroTag: "reset",
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
              TimerRunPause() => [
                FloatingActionButton(
                  heroTag: "resume",
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerResumed()),
                ),
                FloatingActionButton(
                  heroTag: "reset",
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
              TimerRunComplete() => [
                FloatingActionButton(
                  heroTag: "resume",
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
            },
          ],
        );
      },
    );
  }
}
