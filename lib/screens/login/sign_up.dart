import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/components.dart';
import 'package:flutter_bloc_login_example/shared/screen_transitions/slide.transition.dart';

class SignUpScreen extends StatefulWidget {
  final String email;
  const SignUpScreen({this.email = "", super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenMiddle,
      appBar: AppBar(
        title: const Text('SignUp'),
        backgroundColor: ColorsCustom.loginScreenMiddle,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InputLogin(
                validator: _validatorEmail,
                prefixIcon: Icons.account_circle,
                hint: 'email',
                keyboardType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              const SizedBox(height: 30.0),
              InputLogin(
                prefixIcon: Icons.lock,
                hint: 'senha',
                obscureText: true,
                textEditingController: passController,
              ),
              const SizedBox(height: 30.0),
              _buttonSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatorEmail(value) {
    RegExp regExp = RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$");
    if (!regExp.hasMatch(value)) {
      return "type a valid email";
    }
    return null;
  }

  _signUp() {
    if (_formKey.currentState!.validate()) {
      context.read<BlocAuthCubit>().signUpEvent();
    }
  }

  Widget _buttonSignUp() {
    return BlocBuilder<BlocAuthCubit, AuthState>(
      buildWhen: (previusState, state) {
        if (state is LoadedSignUpState) {
          // BlocProvider.of<BlocAuthCubit>(context).add(ResetStateEvent());
          context.read<BlocAuthCubit>().resetStateEvent();
          Navigator.pushReplacement(context,
              SlideRightRoute(page: LoginScreen(email: emailController.text)));
        } else if (state is ErrorSignUpState) {
          const AlertDialog(
            title: Text('Alert'),
            content: Text('Error on loading SignUp.'),
          );
        }
        return true;
      },
      builder: (context, state) {
        if (state is LoadingSignUpState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'loading ...',
            onPressed: () => {},
          );
        } else if (state is LoadedSignUpState) {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'Success!',
            onPressed: () => {},
          );
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'OK',
            onPressed: () => _signUp(),
          );
        }
      },
    );
  }
}
