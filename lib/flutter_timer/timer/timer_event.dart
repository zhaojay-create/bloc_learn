part of 'timer_bloc.dart';

sealed class TimerEvent {
  const TimerEvent();
}

// 计时器开始事件
class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

// 计时器暂停事件
final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

// 计时器恢复事件
final class TimerResumed extends TimerEvent {
  const TimerResumed();
}

// 计时器重置事件
class TimerReset extends TimerEvent {
  const TimerReset();
}

// 通知 TimerBloc 已发生一次计时, 用于更新 UI
class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});
  final int duration;
}
