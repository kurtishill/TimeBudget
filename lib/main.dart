import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/proxy/factory/mock_proxy_factory.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/proxy/factory/real_proxy_factory.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/state/app_state_base.dart';
import 'package:time_budget/utils/theme_bloc.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/views/auth.dart';
import 'package:time_budget/views/category.dart';
import 'package:time_budget/views/main.dart';

void main() => runApp(TimeBudgetApp());

class TimeBudgetApp extends StatefulWidget {
  @override
  _TimeBudgetAppState createState() => _TimeBudgetAppState();
}

class _TimeBudgetAppState extends State<TimeBudgetApp> {
  final AppStateBase appState = AppState();

  bool _authenticated = false;

  @override
  void initState() {
    appState.onUserChanged.listen((user) {
      /// Not logged in
      if (user == null) {
        setState(() => _authenticated = false);
      } else if (user != null && user.token.isNotEmpty) {
        setState(() => _authenticated = true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Proxy factory configured to use the mock proxy throughout the app
    // ProxyFactory.configure(MockProxyFactory());
    ProxyFactory.configure(RealProxyFactory(ip: '10.37.55.227', port: '8080'));

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(builder: (context) => ThemeBloc()),
        BlocProvider<MainBloc>(builder: (context) => MainBloc()),
        BlocProvider<AuthBloc>(builder: (context) => AuthBloc()),
        BlocProvider<CalendarBloc>(builder: (context) => CalendarBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Time Budget',
            theme: theme,
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) =>
                  _authenticated ? MainView() : AuthView(),
            },
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case CategoryView.routeName:
                  final args = settings.arguments as Map<String, dynamic>;
                  final category = args['category'] as Category;
                  final categoryId = category.id;
                  final startTime = args['startTime'] as DateTime;
                  final endTime = args['endTime'] as DateTime;
                  return MaterialPageRoute(
                    builder: (context) => BlocProvider<CategoryBloc>(
                      builder: (context) => CategoryBloc(categoryId),
                      child: CategoryView(
                        category: category,
                        startTime: startTime,
                        endTime: endTime,
                      ),
                    ),
                  );
                default:
                  return MaterialPageRoute(
                    builder: (context) => AuthView(),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
