import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/locator.dart';

void main() {
  Locator.setup();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAuthCubit>(
            create: (BuildContext context) => BlocAuthCubit()),
      ],
      child: const MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Bloc Login Demo',
        home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlocAuthCubit>().forceLoginEvent();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
