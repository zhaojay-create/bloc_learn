import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import 'package:bloc_learn/infinite_list/posts/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required http.Client httpClient})
    : _httpClient = httpClient,
      super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  final http.Client _httpClient;

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      final posts = await _fetchPosts(startIndex: state.posts.length);

      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }

      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: [...state.posts, ...posts],
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts({required int startIndex}) async {
    try {
      print('>>> before request');
      // final uri = Uri.https('jsonplaceholder.typicode.com', 'posts', {
      //   '_start': '$startIndex',
      //   '_limit': '$_postLimit',
      // });

      // https://dummyjson.com/posts?limit=20&skip=2
      final uri = Uri(
        scheme: 'https',
        host: 'dummyjson.com',
        path: 'posts',
        queryParameters: {'limit': '$_postLimit', 'skip': '$startIndex'},
      );

      print('>>> uri: $uri');

      final response = await _httpClient.get(uri);

      print('>>> statusCode: ${response.statusCode}');
      print('>>> body: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body)['posts'];
        if (body is List) {
          return body.map<Post>((e) {
            final map = e as Map<String, dynamic>;
            return Post(
              id: map['id'] as int,
              title: map['title'] as String,
              body: map['body'] as String,
            );
          }).toList();
        } else {
          throw Exception('Unexpected JSON format');
        }
      }
      throw Exception(
        'error fetching posts, statusCode: ${response.statusCode}',
      );
    } catch (e, s) {
      print('>>> request error: $e');
      print(s);
      rethrow; // 继续往上抛
    }
  }
}
