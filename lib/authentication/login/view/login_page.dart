import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_learn/authentication/login/bloc/login_bloc.dart';
import 'package:bloc_learn/authentication/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (_) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
