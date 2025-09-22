import 'package:bloc_learn/bloc_to_bloc_communication_listener/constants/enums.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_listener/logic/cubit/counter_cubit.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_listener/logic/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtbclScreen extends StatelessWidget {
  final Connectivity connectivity; // 网络连接

  const BtbclScreen({super.key, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc to Bloc 监听通信')),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bloc to Bloc Communication'),
                SizedBox(height: 20),
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    switch (state) {
                      case InternetConnected(connectionType: var type):
                        return Text('Connected to ${type.name}');
                      case InternetDisconnected():
                        return const Text('Disconnected');
                      case InternetLoading():
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 20),
                // bloc 监听通信
                // 当 InternetCubit 的状态变化时，CounterCubit 的状态也会跟着变化
                BlocListener<InternetCubit, InternetState>(
                  listener: (context, state) {
                    // print("InternetCubit changed: $state"); // ✅ 打印调试
                    if (state is InternetConnected &&
                        state.connectionType == ConnectionType.wifi) {
                      // print("Increment counter"); // ✅ 打印调试
                      context.read<CounterCubit>().increment();
                    } else if (state is InternetConnected &&
                        state.connectionType == ConnectionType.mobile) {
                      // print("Decrement counter"); // ✅ 打印调试
                      context.read<CounterCubit>().decrement();
                    }
                  },
                  child: BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return Text(
                        'Listened Counter Value: ${state.count}',
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
