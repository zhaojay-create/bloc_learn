part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

// post 列表数据获取事件
final class PostFetched extends PostEvent {}
