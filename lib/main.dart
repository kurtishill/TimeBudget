import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/proxy/factory/mock_proxy_factory.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/utils/theme_bloc.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/views/auth.dart';
import 'package:time_budget/views/main.dart';

/// TODO Temporary
const LOGGED_IN = false;

void main() => runApp(TimeBudgetApp());

class TimeBudgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Proxy factory configured to use the mock proxy throughout the app
    ProxyFactory.configure(MockProxyFactory());

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        ),
        BlocProvider<MainBloc>(
          builder: (context) => MainBloc(),
        ),
        BlocProvider<AuthBloc>(
          builder: (context) => AuthBloc(),
        ),
      ],
      child: BlocProvider<ThemeBloc>(
        builder: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, theme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Time Budget',
              theme: theme,
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) =>
                    LOGGED_IN ? MainView() : AuthView(),
              },
            );
          },
        ),
      ),
    );
  }
}
