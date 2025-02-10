import 'package:flutter/material.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/auth_request.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/models/user.dart';
import 'package:sw_teste/repository/login_repository.dart';
import 'package:sw_teste/services/auth.dart';
import 'package:sw_teste/services/setup_locator.dart';

class LoginController with ChangeNotifier {
  final LoginRepository repository = LoginRepository();
  ValueNotifier<AuthRequest> auth = ValueNotifier(AuthRequest(
    grantType: "password",
    clientId: "user",
  ));
  ValueNotifier<AuthService> authService = ValueNotifier(getIt<AuthService>());
  ValueNotifier<bool> load = ValueNotifier(false);

  Future<Either<AppError, Auth>> login() async {
    load.value = true;
    notifyListeners();
    Either<AppError, Auth> result = await repository.login(auth.value);
    result.fold((error) {}, (Auth auth) async {
      await authService.value.saveTokens(auth);
      Either<AppError, User> r = await repository.fetchUser();
    });
    load.value = false;
    notifyListeners();
    return result;
  }

  onChangedUsername(String value) {
    auth.value.username = value;
  }

  onSavedUsername(String value) {
    auth.value.username = value;
  }

  validateUsername(String value) => value.length < 2 ? 'Insira um usuário válido' : null;
  onChangedPassword(String value) {
    auth.value.password = value;
  }

  onSavedPassword(String value) {
    auth.value.password = value;
  }

  validatePassword(String value) => value.length < 2 ? 'Insira uma senha válida' : null;
}
