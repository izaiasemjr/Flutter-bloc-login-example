import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/components.dart';
import 'package:flutter_bloc_login_example/shared/screen_transitions/slide.transition.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  String _validatorEmail(value) {
    RegExp regExp = RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$");
    if (!regExp.hasMatch(value)) {
      return "type a valid email";
    }
    return null;
  }

  _signUp() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<BlocAuth>(context).add(SignUpEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenMiddle,
      appBar: new AppBar(
        title: new Text('Cadastro'),
        backgroundColor: ColorsCustom.loginScreenMiddle,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InputLogin(
                validator: _validatorEmail,
                prefixIcon: Icons.account_circle,
                label: 'Email',
                hint: 'seu email',
                keyboardType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              SizedBox(height: 30.0),
              InputLogin(
                prefixIcon: Icons.lock,
                label: 'Senha',
                hint: 'sua senha',
                obscureText: true,
                textEditingController: passController,
              ),
              SizedBox(height: 30.0),
              _buttonSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonSignUp() {
    return BlocBuilder<BlocAuth, AuthState>(
      condition: (previusState, state) {
        if (state is LoadedSignUpState) {
          BlocProvider.of<BlocAuth>(context).add(ResetStateEvent());
          Navigator.push(context, SlideRightRoute(page: LoginScreen()));
        } else if (state is ErrorSignUpState) {
          AlertDialog(
            title: Text('Alert'),
            content: Text('Error on loading SignUp.'),
          );
        }
        return;
      },
      builder: (context, state) {
        if (state is LoadingSignUpState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'SignUp ...',
            mOnPressed: () => {},
          );
        } else if (state is LoadedSignUpState) {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'Success!',
            mOnPressed: () => {},
          );
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'SignUp',
            mOnPressed: () => _signUp(),
          );
        }
      },
    );
  }
}
