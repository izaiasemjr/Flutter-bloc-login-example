import 'package:flutter_bloc_login_example/shared/api_auth.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static GetIt _i;
  static GetIt get instance => _i;

  Locator.setup() {
    _i = GetIt.I;

    _i.registerSingleton<ApiAuth>(
      ApiAuth(),
    );
  }
}
