import 'package:counter/logic/cubits/cubit/counter_cubit.dart';
import 'package:counter/presentation/screens/home/home.dart';
import 'package:counter/presentation/screens/me/me.dart';
import 'package:counter/presentation/screens/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                  value: _counterCubit,
                  child: HomeScreen(
                    title: 'Home',
                    color: Colors.blueAccent,
                  ),
                ));
        break;
      case '/me':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                    value: _counterCubit,
                    child: MeScreen(
                      title: 'Me',
                      color: Colors.redAccent,
                    )));
        break;
      case '/settings':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                    value: _counterCubit,
                    child: SettingsScreen(
                      title: 'Settings',
                      color: Colors.greenAccent,
                    )));
        break;
      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.dispose();
  }
}


