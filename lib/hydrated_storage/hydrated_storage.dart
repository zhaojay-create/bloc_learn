import 'package:bloc_learn/hydrated_storage/logic/cubit/hydrated_count_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HydratedStorage extends StatelessWidget {
  const HydratedStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HydratedCountCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Hydrated Storage')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<HydratedCountCubit, HydratedCountState>(
                builder: (context, state) {
                  return Text('Count: ${state.count}');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        child: const Text('Increment'),
                        onPressed: () {
                          context.read<HydratedCountCubit>().increment();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Builder(
                    builder: (context) => ElevatedButton(
                      child: const Text('Decrement'),
                      onPressed: () {
                        context.read<HydratedCountCubit>().decrement();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
