import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/server_facade.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/state/app_state_base.dart';
import 'package:time_budget/utils/auth_mode.dart';
import '../bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IServerFacade _serverFacade = ServerFacade();
  AppStateBase _appState = AppState();

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthenticateAuthEvent) {
      yield LoadingAuthState();

      final String username = event.data['username'];
      final String password = event.data['password'];
      String email = '';

      if (event.authMode == AuthMode.LOGIN) {
        final user = await _serverFacade.login(username, password);
        _appState.authenticate(user);

        yield InitialAuthState();
      } else if (event.authMode == AuthMode.SIGNUP) {
        email = event.data['email'];

        final user = await _serverFacade.signUp(username, password, email);
        _appState.authenticate(user);

        yield InitialAuthState();
      }
    }
  }
}
