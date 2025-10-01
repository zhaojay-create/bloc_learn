import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_learn/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_learn/hydrated_storage/logic/utility/app_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bloc_learn/router/app_route.dart';
import 'package:user_repository/user_repository.dart';

// void main() {
//   runApp(MainApp(appRouter: AppRouter()));
// }

// 持久化存储 入口位置
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 本地持久化存储
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  Bloc.observer = AppBlocObserver(); // 为 BloC 注册观察者

  runApp(MainApp(appRouter: AppRouter()));
}

class MainApp extends StatefulWidget {
  final AppRouter appRouter; // 路由

  const MainApp({super.key, required this.appRouter});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    // MultiRepositoryProvider 用于提供多个 Repository
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(create: (_) => UserRepository()),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) {
          return AuthenticationBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
            userRepository: context.read<UserRepository>(),
          )..add(AuthenticationSubscriptionRequested());
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Flutter Demo',
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamed(AppRouter.profilePage);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamed(AppRouter.loginPage);
                    break;
                  case AuthenticationStatus.unknown:
                    break;
                }
              },
              child: child,
            );
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
              titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
            ),
          ),
          onGenerateRoute: widget.appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
