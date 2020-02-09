import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/locator.dart';

import 'bloc/auth/auth_event.dart';

void main() {
  Locator.setup();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAuth>(create: (BuildContext context) => BlocAuth()),
      ],
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'AWS Cogntio Bloc Demo',
        home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocAuth>(context).add(ForceLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
