import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(count: 0, isIncremented: false));

  void increment() {
    emit(CounterState(count: state.count + 1, isIncremented: true));
  }

  void decrement() {
    emit(CounterState(count: state.count - 1, isIncremented: false));
  }
}
