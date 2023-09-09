import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/components.dart';
import 'package:flutter_bloc_login_example/shared/screen_transitions/slide.transition.dart';
import 'package:flutter_bloc_login_example/shared/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final numConfirmationController = TextEditingController();
  final newPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    numConfirmationController.dispose();
    newPassController.dispose();
  }

  _forgotPassword() {
    if (_formKey.currentState!.validate()) {
      context.read<BlocAuthCubit>().forgotPasswordEvent();
    }
  }

  _resendCode() {
    context.read<BlocAuthCubit>().resendCodeEvent(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenMiddle,
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: ColorsCustom.loginScreenMiddle,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _textTitle(),
                const SizedBox(height: 30.0),
                InputLogin(
                  prefixIcon: Icons.local_offer,
                  hint: 'Code',
                  keyboardType: TextInputType.number,
                  textEditingController: numConfirmationController,
                ),
                const SizedBox(height: 30.0),
                InputLogin(
                  prefixIcon: Icons.lock,
                  hint: 'new password',
                  obscureText: true,
                  textEditingController: newPassController,
                ),
                const SizedBox(height: 30.0),
                _buttonSignUp(),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () => _resendCode(),
                  child: Text(
                    'Resend Code',
                    textAlign: TextAlign.center,
                    style: TextStylesLogin.textLink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textTitle() {
    return BlocBuilder<BlocAuthCubit, AuthState>(
      builder: (previusState, state) {
        if (state is LoadingResendCodeState) {
          return ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              const SizedBox(
                child: SpinKitWave(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Resend code for ${widget.email} ...',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return Text(
            "Verify the code sent to email ${widget.email}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget _buttonSignUp() {
    return BlocBuilder<BlocAuthCubit, AuthState>(
      buildWhen: (previusState, state) {
        if (state is LoadedForgotPasswordState) {
          Navigator.pushReplacement(
              context, SlideDownRoute(page: const LoginScreen()));
        } else if (state is ErrorSignUpState) {
          const AlertDialog(
            title: Text('Alert'),
            content: Text('Error on changing Password.'),
          );
        }
        return true;
      },
      builder: (context, state) {
        if (state is LoadingForgotPasswordState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'Loading ...',
            onPressed: () => {},
          );
        } else if (state is LoadedForgotPasswordState) {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'Success!',
            onPressed: () => {},
          );
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'OK',
            onPressed: () => _forgotPassword(),
          );
        }
      },
    );
  }
}
