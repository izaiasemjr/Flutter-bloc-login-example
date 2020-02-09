import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/screen_transitions/fade.transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
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
    return BlocBuilder<BlocAuth, AuthState>(condition: (previousState, state) {
      if (state is UnlogedState) {
        Navigator.pushReplacement(context, FadeRoute(page: LoginScreen()));
      }
      return;
    }, builder: (context, state) {
      if (state is LoadingLogoutState) {
        return SizedBox(
          child: SpinKitWave(
            color: Colors.white,
          ),
        );
      }
      return Center(
        child: InkWell(
          onTap: () => BlocProvider.of<BlocAuth>(context).add(LogoutEvent()),
          child: Text(
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
