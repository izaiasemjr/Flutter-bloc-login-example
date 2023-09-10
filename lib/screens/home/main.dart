import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/screen_transitions/fade.transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenMiddle,
      body: _logout(),
    );
  }

  _logout() {
    return BlocBuilder<BlocAuthCubit, AuthState>(
        buildWhen: (previousState, state) {
      if (state is UnlogedState) {
        Navigator.pushReplacement(
            context, FadeRoute(page: const LoginScreen()));
      }
      return true;
    }, builder: (context, state) {
      if (state is LoadingLogoutState) {
        return const SizedBox(
          child: SpinKitWave(
            color: Colors.white,
          ),
        );
      }
      return Center(
        child: InkWell(
          onTap: () => context.read<BlocAuthCubit>().logoutEvent(),
          child: const Text(
            "Logout",
            style: TextStyle(
                fontSize: 26,
                decoration: TextDecoration.underline,
                color: Colors.white),
          ),
        ),
      );
    });
  }
}
