import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('[onCreate] ${bloc.runtimeType} 已创建，初始状态: ${bloc.state}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('[onEvent] ${bloc.runtimeType} 收到事件: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('[onChange] ${bloc.runtimeType} 状态变更: $change');
    // change 结构: { currentState, nextState }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('[onTransition] ${bloc.runtimeType} 发生状态迁移: $transition');
    // transition 结构: { currentState, event, nextState }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('[onError] ${bloc.runtimeType} 出错: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('[onClose] ${bloc.runtimeType} 已关闭');
  }
}
