import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_stream/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late Connectivity connectivity;
  late StreamSubscription<List<ConnectivityResult>>
  connectivityStreamSubscription;

  // 初始化时，状态设为加载中（InternetLoading）
  //  super(InternetLoading()): 在 InternetCubit 构造函数执行之前，先调用父类 Cubit 的构造函数，并传入 初始状态。
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    // 初始化时，订阅网络状态变化
    _subscribeToConnectivity();
  }

  // 订阅连接状态变化的流
  void _subscribeToConnectivity() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((
      result,
    ) {
      if (result.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (result.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (result.contains(ConnectivityResult.none)) {
        emitInternetDisconnected();
      }
    });
  }

  // 每次 emit(...) 并不是修改旧状态，而是 创建一个新的状态实例。
  // emit 派发“已连接”状态，并携带连接类型（wifi、mobile 等）
  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  // emit 派发“已断开”状态
  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
