import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/screens/home/main.dart';
import 'package:flutter_bloc_login_example/screens/login/signUp.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/components.dart';
import 'package:flutter_bloc_login_example/shared/screen_transitions/slide.transition.dart';
import 'package:flutter_bloc_login_example/shared/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passController = TextEditingController();
  var size;
  final regExp = RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$");

  _login() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<BlocAuth>(context).add(LoginEvent());
    }
  }

  String _validatorEmail(value) {
    if (!regExp.hasMatch(value)) {
      return "type a valid email";
    }
    return null;
  }

  _forgotPassword() {
    if (regExp.hasMatch(loginController.text))
      Navigator.push(
          context,
          SlideDownRoute(
              page: ForgotPasswordScreen(
            email: loginController.text,
          )));
    else
      showDialog(
        context: context,
        builder: (context) => Alert(
          titleText: 'Alert',
          contentText:
              'Please type a valid Email in login field to change your password.',
        ),
      );
  }

  _signUp() {
    Navigator.push(context, SlideLeftRoute(page: SignUpScreen()));
  }

  @override
  void initState() {
    super.initState();
    loginController.text = '';
    passController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    loginController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenUp,
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.0671),
          Container(
              height: size.height * 0.178,
              width: size.width * 0.316,
              child: Image.asset(
                'lib/assets/images/pebal.png',
                fit: BoxFit.contain,
              )),
          SizedBox(height: size.height * 0.085),
          Expanded(
            child: _formLogin(),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() {
    return BlocBuilder<BlocAuth, AuthState>(condition: (previousState, state) {
      if (state is LogedState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      return;
    }, builder: (context, state) {
      if (state is ForcingLoginState) {
        return SizedBox(
          child: SpinKitWave(
            color: Colors.white,
          ),
        );
      } else {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  InputLogin(
                    validator: _validatorEmail,
                    prefixIcon: Icons.account_circle,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: loginController,
                  ),
                  SizedBox(height: size.height * 0.03),
                  InputLogin(
                    prefixIcon: Icons.lock,
                    hint: 'Password',
                    obscureText: true,
                    textEditingController: passController,
                  ),
                  SizedBox(height: size.height * 0.035),
                  _buttonLogin(),
                  SizedBox(height: size.height * 0.01),
                  InkWell(
                    onTap: () => _forgotPassword(),
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStylesLogin.textLink,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * 0.084),
                    child: Divider(
                      height: size.height * 0.14,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () => _signUp(),
                    child: Text(
                      'SIGN UP with your email',
                      textAlign: TextAlign.right,
                      style: TextStylesLogin.textLink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buttonLogin() {
    return BlocBuilder<BlocAuth, AuthState>(
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'LOGIN ...',
            mOnPressed: () => {},
          );
        } else if (state is LogedState) {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'CONECTED!',
            mOnPressed: () => {},
          );
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'SIGN IN',
            mOnPressed: () => _login(),
          );
        }
      },
    );
  }
}
