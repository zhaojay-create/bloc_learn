part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

final class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status; // 当前状态
  final List<Post> posts; // 存储获取的帖子列表
  final bool hasReachedMax; // 将告诉表示层是否已达到最大帖子数

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) => PostState(
    status: status ?? this.status,
    posts: posts ?? this.posts,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
  );

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}

final class PostInitial extends PostState {}
