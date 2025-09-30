import 'package:bloc_learn/infinite_list/posts/bloc/post_bloc.dart';
import 'package:bloc_learn/infinite_list/posts/view/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class InfiniteListPage extends StatelessWidget {
  const InfiniteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite List')),
      body: BlocProvider(
        // 创建对象后，立刻对这个对象调用方法/设置属性，并且返回这个对象本身
        // 创建 Bloc 后，马上发出一个 PostFetched 事件作为初始加载。
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        // create: (_) => PostBloc(httpClient: IOClient(HttpClient()..findProxy = (_) => 'DIRECT'))..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
