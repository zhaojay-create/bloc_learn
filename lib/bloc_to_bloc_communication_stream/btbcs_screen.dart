import 'package:bloc_learn/bloc_to_bloc_communication_stream/logic/cubit/counter_cubit.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_stream/logic/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtbcsScreen extends StatelessWidget {
  final Connectivity connectivity; // 网络连接

  const BtbcsScreen({super.key, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) =>
              CounterCubit(internetCubit: context.read<InternetCubit>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc to Bloc 流通信')),
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
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    return Text(
                      'Counter Value: ${state.count}',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
