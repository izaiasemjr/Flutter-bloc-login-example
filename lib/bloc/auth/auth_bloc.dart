import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/shared/api_auth.dart';
import 'package:flutter_bloc_login_example/shared/locator.dart';

import 'auth_state.dart';

// class BlocAuth2 extends Bloc<AuthEvent, AuthState> {
//   @override
//   get initialState => UnlogedState();

//   bool _isLoged = false;

//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     try {
//       if (event is LoginEvent) {
//         yield LoadingLoginState();

//         await Locator.instance.get<ApiAuth>().login();

//         yield LogedState();
//       } else if (event is LogoutEvent) {
//         yield LoadingLogoutState();
//         await Locator.instance.get<ApiAuth>().logout();

//         yield UnlogedState();
//       } else if (event is ForceLoginEvent) {
//         yield ForcingLoginState();

//         // verify if is loged
//         await Future.delayed(Duration(seconds: 1));

//         yield _isLoged ? LogedState() : UnlogedState();

//         yield LoginErrorState();
//       } else if (event is SignUpEvent) {
//         yield LoadingSignUpState();

//         await Locator.instance.get<ApiAuth>().signUp();

//         yield LoadedSignUpState();
//       } else if (event is ForgotPasswordEvent) {
//         yield LoadingForgotPasswordState();

//         await Locator.instance.get<ApiAuth>().changePassword();

//         yield LoadedForgotPasswordState();
//       } else if (event is ResendCodeEvent) {
//         yield LoadingResendCodeState();

//         await Locator.instance.get<ApiAuth>().resendCode(email: event.email);

//         yield LoadedResendCodeState();
//       } else {
//         yield UnlogedState();
//       }
//     } catch (e) {
//       yield LoginErrorState();
//     }
//   }
// }

class BlocAuthCubit extends Cubit<AuthState> {
  BlocAuthCubit() : super(UnlogedState());

  bool _isLoged = false;

  Future loginEvent() async {
    try {
      emit(LoadingLoginState());
      await Locator.instance.get<ApiAuth>().login();

      _isLoged = true;

      emit(LogedState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }

  Future logoutEvent() async {
    try {
      emit(LoadingLogoutState());
      await Locator.instance.get<ApiAuth>().logout();
      emit(UnlogedState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }

  Future forceLoginEvent() async {
    try {
      emit(ForcingLoginState());
      await Future.delayed(const Duration(seconds: 1));
      emit(_isLoged ? LogedState() : UnlogedState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }

  Future signUpEvent() async {
    try {
      emit(LoadingSignUpState());
      await Locator.instance.get<ApiAuth>().signUp();
      emit(LoadedSignUpState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }

  Future forgotPasswordEvent() async {
    try {
      emit(LoadingForgotPasswordState());
      await Locator.instance.get<ApiAuth>().changePassword();
      emit(LoadedForgotPasswordState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }

  Future resendCodeEvent({required String email}) async {
    try {
      emit(LoadingResendCodeState());
      await Locator.instance.get<ApiAuth>().resendCode(email: email);
      emit(LoadedResendCodeState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }
}
