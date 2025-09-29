part of 'counter_cubit.dart';

final class CounterState {
  final int count;
  final bool isIncremented;

  CounterState({required this.count, required this.isIncremented});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'count': count, 'isIncremented': isIncremented};
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      count: map['count'] as int,
      isIncremented: map['isIncremented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source) as Map<String, dynamic>);
}
