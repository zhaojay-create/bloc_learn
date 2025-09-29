import 'dart:async';
import 'dart:convert';

import 'package:bloc_learn/bloc_to_bloc_communication_stream/constants/enums.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_stream/logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
    : super(CounterState(count: 0, isIncremented: false)) {
    // 初始化时，订阅网络状态变化
    _subscribeToInternetCubit();
  }

  // 监听 网络 cubit 的状态变化
  void _subscribeToInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.mobile) {
        decrement();
      }
    });
  }

  void increment() {
    emit(CounterState(count: state.count + 1, isIncremented: true));
  }

  void decrement() {
    emit(CounterState(count: state.count - 1, isIncremented: false));
  }
}
