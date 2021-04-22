import 'package:counter/presentation/screens/me/me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubits/cubit/counter_cubit.dart';
import 'presentation/screens/home/home.dart';
import 'presentation/screens/settings/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => BlocProvider.value(
                value: _counterCubit,
                child: HomeScreen(
                  title: 'Home',
                  color: Colors.blueAccent,
                ),
              ),
          '/me': (context) => BlocProvider.value(
              value: _counterCubit,
              child: MeScreen(
                title: 'Me',
                color: Colors.redAccent,
              )),
          '/settings': (context) => BlocProvider.value(
              value: _counterCubit,
              child: SettingsScreen(
                title: 'Settings',
                color: Colors.amberAccent,
              ))
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _counterCubit.close();
    super.dispose();
  }
}
