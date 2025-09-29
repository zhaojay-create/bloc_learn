import 'package:bloc_learn/hydrated_storage/logic/utility/app_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bloc_learn/router/app_route.dart';

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

class MainApp extends StatelessWidget {
  final AppRouter appRouter; // 路由

  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
