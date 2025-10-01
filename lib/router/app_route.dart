import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bloc_learn/authentication/authentication.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_listener/btbcl_screen.dart';
import 'package:bloc_learn/bloc_to_bloc_communication_stream/btbcs_screen.dart';
import 'package:bloc_learn/flutter_timer/flutter_timer.dart';
import 'package:bloc_learn/hydrated_storage/hydrated_storage.dart';
import 'package:bloc_learn/infinite_list/infinite_list_page.dart';
import 'package:bloc_learn/router/home_screen.dart';

class AppRouter {
  static const home = '/';
  static const blocStream = '/bloc_to_bloc_communication_stream';
  static const blocListener = '/bloc_to_bloc_communication_listener';
  static const hydratedStorage = '/hydrated_storage';
  static const flutterTimer = '/flutter_timer';
  static const infiniteList = '/infinite_list';
  static const loginPage = '/login_page';
  static const profilePage = '/profile_page';

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
      case flutterTimer:
        return MaterialPageRoute(builder: (_) => const FlutterTimer());
      case infiniteList:
        return MaterialPageRoute(builder: (_) => const InfiniteListPage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const Text('4045'));
    }
  }
}
