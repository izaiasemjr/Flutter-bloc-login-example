class ApiAuth {
  // implement your workflow for authentication with your server

  Future login() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future changePassword() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future signUp() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future resendCode({email}) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
