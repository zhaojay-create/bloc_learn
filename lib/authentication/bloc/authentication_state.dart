part of 'authentication_bloc.dart';

// 一个类，但是有多个 命名构造函数，表示不同状态。
class AuthenticationState extends Equatable {
  // 1. 私有命名构造函数：统一初始化入口
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  // 2. 公开命名构造函数：不同状态的工厂方法，调用私有构造函数
  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
    : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
