import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_login_example/shared/api_auth.dart';
import 'package:flutter_bloc_login_example/shared/locator.dart';

import 'auth_state.dart';

class BlocAuth extends Bloc<AuthEvent, AuthState> {
  @override
  get initialState => UnlogedState();

  bool _isLoged = false;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is LoginEvent) {
        yield LoadingLoginState();

        await Locator.instance.get<ApiAuth>().login();

        yield LogedState();
      } else if (event is LogoutEvent) {
        yield LoadingLogoutState();
        await Locator.instance.get<ApiAuth>().logout();

        yield UnlogedState();
      } else if (event is ForceLoginEvent) {
        yield ForcingLoginState();

        // verify if is loged
        await Future.delayed(Duration(seconds: 1));

        yield _isLoged ? LogedState() : UnlogedState();

        yield LoginErrorState();
      } else if (event is SignUpEvent) {
        yield LoadingSignUpState();

        await Locator.instance.get<ApiAuth>().signUp();

        yield LoadedSignUpState();
      } else if (event is ForgotPasswordEvent) {
        yield LoadingForgotPasswordState();

        await Locator.instance.get<ApiAuth>().changePassword();

        yield LoadedForgotPasswordState();
      } else {
        yield UnlogedState();
      }
    } catch (e) {
      yield LoginErrorState();
    }
  }
}
