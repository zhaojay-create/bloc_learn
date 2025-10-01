part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// 已请求身份验证订阅
final class AuthenticationSubscriptionRequested extends AuthenticationEvent {}

// 已按下注销按钮
final class AuthenticationLogoutPressed extends AuthenticationEvent {}
