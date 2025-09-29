import 'package:bloc_learn/hydrated_storage/hydrated_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:bloc_learn/router/home_screen.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_stream/btbcs_screen.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_listener/btbcl_screen.dart';

class AppRouter {
  static const home = '/';
  static const blocStream = '/bloc_to_bloc_communication_stream';
  static const blocListener = '/bloc_to_bloc_communication_listener';
  static const hydratedStorage = '/hydrated_storage';

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case blocStream:
        return MaterialPageRoute(
          builder: (_) => BtbcsScreen(connectivity: Connectivity()),
        );
      case blocListener:
        return MaterialPageRoute(
          builder: (_) => BtbclScreen(connectivity: Connectivity()),
        );
      case hydratedStorage:
        return MaterialPageRoute(builder: (_) => const HydratedStorage());
      default:
        return MaterialPageRoute(builder: (_) => const Text('4045'));
    }
  }
}
