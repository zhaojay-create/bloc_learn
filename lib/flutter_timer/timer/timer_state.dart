part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

// 初始化状态
final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

// 计时暂停状态
final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

// 计时进行中状态
final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

// 计时完成状态
final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
