import 'dart:developer';
import 'package:counter/contants/enums.dart';
import 'package:counter/logic/cubits/cubit/counter_cubit.dart';
import 'package:counter/logic/cubits/internet/internet_cubit.dart';
import 'package:counter/presentation/screens/me/me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          print(state);
          // TODO: implement listener}
          if(state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
            BlocProvider.of<CounterCubit>(context).increment();
          } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
            BlocProvider.of<CounterCubit>(context).decrement();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                BlocConsumer<CounterCubit, CounterState>(
                  listener: (context, state) {
                    if (state.wasIncremented == true) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(seconds: 2),
                      ));
                    } else if (state.wasIncremented == false) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).decrement();
                      },
                      tooltip: 'Decrement',
                      child: Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).increment();
                        },
                        tooltip: 'Increment',
                        child: Icon(
                          Icons.add,
                        )),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/me');
                  },
                  child: Text('Go to me screen'),
                ),
                SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                  child: Text('Go to settings screen'),
                )
              ],
            ),
          ),
        ));
  }
}
