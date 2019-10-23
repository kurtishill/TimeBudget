import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/utils/auth_mode.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthenticateAuthEvent extends AuthEvent {
  final AuthMode authMode;
  final Map<String, String> data;

  AuthenticateAuthEvent({@required this.authMode, @required this.data});

  @override
  List<Object> get props => [authMode, data];
}
