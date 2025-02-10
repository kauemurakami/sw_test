import 'package:flutter/material.dart';
import 'package:sw_teste/models/auth.dart';
import 'package:sw_teste/models/either.dart';
import 'package:sw_teste/models/error.dart';
import 'package:sw_teste/repository/login_repository.dart';
import 'package:sw_teste/services/auth.dart';
import 'package:sw_teste/services/setup_locator.dart';

class LoginController with ChangeNotifier {
  final LoginRepository repository = LoginRepository();
  ValueNotifier<Auth> auth = ValueNotifier(Auth());

  ValueNotifier<AuthService> authService = ValueNotifier(getIt<AuthService>());

  Future<Either<AppError, Auth>> login() async {
    Either<AppError, Auth> result = await repository.login(auth.value);
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
