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
import 'package:flutter_bloc_login_example/shared/styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final email;

  const ForgotPasswordScreen({Key key, @required this.email}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
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
    if (_formKey.currentState.validate()) {
      BlocProvider.of<BlocAuth>(context).add(ForgotPasswordEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenMiddle,
      appBar: new AppBar(
        title: new Text('Forgot Password'),
        backgroundColor: ColorsCustom.loginScreenMiddle,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Verify the code sent to email ${widget.email}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                InputLogin(
                  prefixIcon: Icons.local_offer,
                  label: 'Confirmation Code',
                  hint: 'Code',
                  keyboardType: TextInputType.number,
                  textEditingController: numConfirmationController,
                ),
                SizedBox(height: 30.0),
                InputLogin(
                  prefixIcon: Icons.lock,
                  label: 'Password',
                  hint: 'new password',
                  obscureText: true,
                  textEditingController: newPassController,
                ),
                SizedBox(height: 30.0),
                _buttonSignUp(),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () => _forgotPassword(),
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

  Widget _buttonSignUp() {
    return BlocBuilder<BlocAuth, AuthState>(
      condition: (previusState, state) {
        if (state is LoadedForgotPasswordState) {
          BlocProvider.of<BlocAuth>(context).add(ResetStateEvent());
          Navigator.push(context, SlideDownRoute(page: LoginScreen()));
        } else if (state is ErrorSignUpState) {
          AlertDialog(
            title: Text('Alert'),
            content: Text('Error on changing Password.'),
          );
        }
        return;
      },
      builder: (context, state) {
        if (state is LoadingForgotPasswordState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'Loading ...',
            mOnPressed: () => {},
          );
        } else if (state is LoadedForgotPasswordState) {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'Success',
            mOnPressed: () => {},
          );
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'Change Password',
            mOnPressed: () => _forgotPassword(),
          );
        }
      },
    );
  }
}
