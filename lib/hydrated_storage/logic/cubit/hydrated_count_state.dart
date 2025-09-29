part of 'hydrated_count_cubit.dart';

final class HydratedCountState {
  final int count;
  final bool isIncremented;

  HydratedCountState({required this.count, required this.isIncremented});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'count': count, 'isIncremented': isIncremented};
  }

  factory HydratedCountState.fromMap(Map<String, dynamic> map) {
    return HydratedCountState(
      count: map['count'] as int,
      isIncremented: map['isIncremented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HydratedCountState.fromJson(String source) =>
      HydratedCountState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HydratedCountCubit{state: count: $count, isIncremented: $isIncremented}';
  }
}
