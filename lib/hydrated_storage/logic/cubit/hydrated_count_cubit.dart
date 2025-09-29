import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'hydrated_count_state.dart';

class HydratedCountCubit extends Cubit<HydratedCountState> with HydratedMixin {
  HydratedCountCubit()
    : super(HydratedCountState(count: 0, isIncremented: false)) {
    hydrate();
  }

  void increment() {
    emit(HydratedCountState(count: state.count + 1, isIncremented: true));
  }

  void decrement() {
    emit(HydratedCountState(count: state.count - 1, isIncremented: false));
  }

  @override
  HydratedCountState? fromJson(Map<String, dynamic> json) {
    return HydratedCountState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HydratedCountState state) {
    return state.toMap();
  }

  @override
  void onChange(Change<HydratedCountState> change) {
    super.onChange(change);
    print(
      'currentState:' +
          change.currentState.toString() +
          '\nflutter: nextState:' +
          change.nextState.toString(),
    );
  }
}
