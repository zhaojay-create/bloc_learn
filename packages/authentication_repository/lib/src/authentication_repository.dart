import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  // 创建一个 StreamController，用于发送认证状态的变化
  // controller.stream → 返回一个 Stream<AuthenticationStatus>，外部订阅这个流就能收到事件
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // 推送一个初始状态
    yield AuthenticationStatus.unauthenticated;
    // 转发 controller 的流
    // yield* 的意思是“把另一个流的所有事件，原封不动转发出来”。
    // 这样，后续 _controller.add(...) 发的事件，都会继续被 status 流订阅到。
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
