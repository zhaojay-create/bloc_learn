import 'package:bloc_learn/router/app_route.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      {
        'title': 'Bloc to Bloc Communication Stream',
        'route': AppRouter.blocStream,
      },
      {
        'title': 'Bloc to Bloc Communication Listener',
        'route': AppRouter.blocListener,
      },
      {'title': 'Hydrated Storage', 'route': AppRouter.hydratedStorage},
      {'title': 'flutter_learn_1_timer', 'route': AppRouter.flutterTimer},
      {
        'title': 'flutter_learn_2_infinite_list',
        'route': AppRouter.infiniteList,
      },
      {'title': 'Login Page', 'route': AppRouter.loginPage},
      {'title': 'Profile Page', 'route': AppRouter.profilePage},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final item = routes[index];
          return ListTile(
            title: Text(item['title']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, item['route']!);
            },
          );
        },
      ),
    );
  }
}
